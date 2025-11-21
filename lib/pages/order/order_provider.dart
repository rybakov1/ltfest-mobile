import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/models/laboratory_learning_type.dart';
import 'package:ltfest/data/models/priority_tariff.dart';
import 'package:ltfest/data/services/api_exception.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/providers/promocode_provider.dart';
import 'package:ltfest/providers/user_provider.dart';
import 'package:ltfest/router/app_routes.dart';

import '../../data/models/festival_tariff.dart';
import '../../providers/loyalty_card_provider.dart';
import '../payment/payment_provider.dart';

enum DeliveryMethod { onFestival, cdek }

enum OrderType { products, festival, laboratory, ltpriority }

@immutable
class OrderState {
  // --- Общие поля для всех заказов ---
  final OrderType orderType;
  final String payerName;
  final String email;
  final String birthdate;
  final String phone;
  final bool isLoading;

  // --- Поля для заказа ТОВАРОВ (Products) ---
  final DeliveryMethod deliveryMethod;
  final Festival? selectedFestival;
  final String deliveryAddress;

  // --- Поля для заказа на ФЕСТИВАЛЬ (Festival) ---
  final String collectiveName; // Название коллектива
  final String participantNames; // Имена участников через запятую
  final int seatCount; // Количество мест

  final String passport; // Имена участников через запятую
  final String residence; // Имена участников через запятую

  final dynamic payableItem;

  const OrderState({
    // Общие
    this.birthdate = "",
    this.orderType = OrderType.products,
    this.payerName = '',
    this.email = '',
    this.phone = '',
    this.isLoading = false,

    // Товары
    this.deliveryMethod = DeliveryMethod.onFestival,
    this.selectedFestival,
    this.deliveryAddress = '',

    // Фестиваль
    this.collectiveName = '',
    this.participantNames = '',
    this.seatCount = 1,
    this.passport = '',
    this.residence = '',
    this.payableItem,
  });

  OrderState copyWith(
      {OrderType? orderType,
      String? payerName,
      String? email,
      String? phone,
      bool? isLoading,
      DeliveryMethod? deliveryMethod,
      Festival? selectedFestival,
      String? deliveryAddress,
      String? collectiveName,
      String? participantNames,
      String? passport,
      String? residence,
      String? birthdate,
      int? seatCount,
      dynamic payableItem}) {
    return OrderState(
      orderType: orderType ?? this.orderType,
      payerName: payerName ?? this.payerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isLoading: isLoading ?? this.isLoading,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      selectedFestival: selectedFestival ?? this.selectedFestival,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      collectiveName: collectiveName ?? this.collectiveName,
      participantNames: participantNames ?? this.participantNames,
      seatCount: seatCount ?? this.seatCount,
      passport: passport ?? this.passport,
      residence: residence ?? this.residence,
      payableItem: payableItem ?? this.payableItem,
      birthdate: birthdate ?? this.birthdate,
    );
  }
}

final allFestivalsProvider = FutureProvider<List<Festival>>((ref) {
  return ref.watch(apiServiceProvider).getFestivals();
});

final orderBasePriceProvider = Provider<int>((ref) {
  final orderState = ref.watch(orderProvider);

  int basePrice = 0;

  switch (orderState.orderType) {
    case OrderType.products:
      basePrice = ref.watch(cartTotalPriceProvider);
      break;
    case OrderType.festival:
      if (orderState.payableItem is FestivalTariff) {
        final tariff = orderState.payableItem as FestivalTariff;
        if (tariff.fact_price != null) {
          basePrice = tariff.fact_price!.toInt() * orderState.seatCount;
        } else {
          basePrice = (tariff.price / 2).toInt() * orderState.seatCount;
        }
      }
      break;
    case OrderType.laboratory:
      if (orderState.payableItem is LearningType) {
        final learningType = orderState.payableItem as LearningType;
        basePrice = learningType.price.toInt() * orderState.seatCount;
      }
      break;
    case OrderType.ltpriority:
      if (orderState.payableItem is PriorityTariff) {
        final tariff = orderState.payableItem as PriorityTariff;
        basePrice = tariff.price.toInt();
      }
      break;
  }
  return basePrice;
});

final orderTotalPriceProvider = Provider<int>((ref) {
  final basePrice = ref.watch(orderBasePriceProvider);
  final promoState = ref.watch(promoCodeNotifierProvider);
  final loyaltyCardState = ref.watch(loyaltyCardNotifierProvider);

  // Сначала проверяем скидку по карте лояльности (у нее приоритет)
  return loyaltyCardState.maybeMap(
    success: (successCardState) {
      final card = successCardState.loyaltyCard;
      // Скидка по карте всегда процентная
      final discountAmount = basePrice * (card.discountPercent / 100);
      final finalPrice = basePrice - discountAmount;
      return finalPrice.isNegative ? 0 : finalPrice.round();
    },
    // Если карты нет или она не применена, проверяем промокод
    orElse: () => promoState.maybeMap(
      success: (successPromoState) {
        final promo = successPromoState.promoCode;
        double discountAmount = 0.0;
        if (promo.discountType == 'percentage') {
          discountAmount = basePrice * (promo.discountValue / 100);
        } else {
          // Фиксированная скидка
          discountAmount =
              min(promo.discountValue.toDouble(), basePrice.toDouble());
        }
        final finalPrice = basePrice - discountAmount;
        return finalPrice.isNegative ? 0 : finalPrice.round();
      },
      // Если ни карты, ни промокода нет, возвращаем базовую цену
      orElse: () => basePrice,
    ),
  );
});

class OrderNotifier extends StateNotifier<OrderState> {
  final Ref _ref;

  OrderNotifier(this._ref) : super(const OrderState());

  void startOrder({required OrderType type, required dynamic item}) {
    state = const OrderState().copyWith(
      orderType: type,
      payableItem: item,
      seatCount: 1,
    );

    _prefillUserData();
  }

  void _prefillUserData() {
    final user = _ref.read(userProvider);
    if (user != null) {
      state = state.copyWith(
        payerName: user.lastname!.trim(),
        email: user.email,
        phone: user.phone,
        collectiveName: user.collectiveName,
      );
    }
  }

  void setOrderType(OrderType type) => state = state.copyWith(orderType: type);

  void reset(OrderType type) {
    state = const OrderState();
    setOrderType(type);
    _prefillUserData();
  }

  void updatePayerName(String value) =>
      state = state.copyWith(payerName: value);

  void updateEmail(String value) => state = state.copyWith(email: value);
  void updateBirthdate(String value) =>
      state = state.copyWith(birthdate: value);
  void updatePhone(String value) => state = state.copyWith(phone: value);

  void updatePassport(String value) => state = state.copyWith(passport: value);

  void updateResidence(String value) =>
      state = state.copyWith(residence: value);

  void updateCollectiveName(String value) =>
      state = state.copyWith(collectiveName: value);

  void updateParticipantNames(String value) =>
      state = state.copyWith(participantNames: value);

  void updateSeatCount(int value) => state = state.copyWith(seatCount: value);

  void updateDeliveryAddress(String value) =>
      state = state.copyWith(deliveryAddress: value);

  void selectFestival(Festival festival) =>
      state = state.copyWith(selectedFestival: festival);

  void setDeliveryMethod(DeliveryMethod method) {
    if (method == DeliveryMethod.onFestival) {
      state = state.copyWith(deliveryMethod: method, deliveryAddress: '');
    } else {
      state = state.copyWith(deliveryMethod: method, selectedFestival: null);
    }
  }

  String _mapOrderTypeToStrapi(OrderType type) {
    switch (type) {
      case OrderType.products:
        return 'product';
      case OrderType.festival:
        return 'festival-tariff';
      case OrderType.laboratory:
        return 'laboratory';
      case OrderType.ltpriority:
        return 'loyalty_card';
    }
  }

  Future<void> placeOrderAndPay(BuildContext context, int totalAmount) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);

    final apiService = _ref.read(apiServiceProvider);
    final user = _ref.read(userProvider);
    final cartAsync = _ref.read(cartProvider);

    try {
      final promoState = _ref.read(promoCodeNotifierProvider);
      await promoState.whenOrNull(
        success: (promoCode) async {
          await apiService.applyPromoCode(promoCode);
        },
      );

      final Map<String, dynamic> details = {};

      switch (state.orderType) {
        case OrderType.products:
          details['Имя коллектива'] = state.collectiveName;

          if (cartAsync.value?.items != null) {
            details['Корзина'] = cartAsync.value!.items
                .where((item) => item.productInStock != null)
                .map((item) => {
                      'ID товара': item.productInStock!.id,
                      'Название': item.productInStock!.product?.name ?? 'Товар',
                      'Характеристики':
                          '${item.productInStock!.productColor.title}, ${item.productInStock!.productSize.title}',
                      'Количество': item.quantity,
                      'Цена за штуку': item.productInStock!.price,
                    })
                .toList();
          }


          details['Метод доставки'] = state.deliveryMethod.name == "onFestival"
              ? "Заберу на фестивале"
              : "Доставка до адреса";

          if (state.deliveryAddress.isNotEmpty) {
            details['Адрес доставки'] = state.deliveryAddress;
          }

          if (state.selectedFestival?.title != null) {
            details['Фестиваль'] = state.selectedFestival!.title;
          }
          break;
        case OrderType.festival:
          details['Имя коллектива'] = state.collectiveName;
          details['Имена участников'] = state.participantNames;
          details['Количество мест'] = state.seatCount;
          break;
        case OrderType.laboratory:
          if (state.payableItem is LearningType) {
            final learningType = state.payableItem as LearningType;
            details['ID типа обучения'] = learningType.id;
            details['Тип обучения'] = learningType.type;
            details['Количество мест'] = state.seatCount;
          }
          break;
        case OrderType.ltpriority:
          details['Имя коллектива'] = state.collectiveName;
          details['Адрес доставки'] = state.deliveryAddress;
          details['Паспорт'] = state.passport;
          break;
      }

      details.removeWhere((key, value) =>
          value == null || value == '' || (value is int && value == 0));

      final List<Map<String, dynamic>> orderedDetailsList = details.entries
          .map((entry) => {entry.key: entry.value})
          .toList();

      final orderData = {
        'name': state.payerName,
        'email': state.email,
        'phone': state.phone,
        'amount': totalAmount,
        'type': _mapOrderTypeToStrapi(state.orderType),
        'details': orderedDetailsList,
        'users_permissions_user': user?.id,
        'festival_tariff':
            state.payableItem is FestivalTariff ? state.payableItem?.id : null,
        'laboratory_learning_type':
            state.payableItem is LearningType ? state.payableItem?.id : null,
        'priority_tariff':
            state.payableItem is PriorityTariff ? state.payableItem?.id : null,
      };

      orderData.removeWhere((key, value) => value == null);

      final paymentResponse = await apiService.initPayment(
        orderData: orderData,
        paymentData: {
          'amount': totalAmount,
          'description':
              'Оплата заказа от ${state.payerName} с мобильного приложения',
          'successUrl': 'ltfestapp://payment/success/{PaymentId}',
          'failUrl': 'ltfestapp://payment/fail/{PaymentId}',
        },
      );

      if (paymentResponse.success && paymentResponse.paymentUrl != null) {
        if (paymentResponse.paymentId != null) {
          final paymentNotifier = _ref.read(paymentNotifierProvider.notifier);
          paymentNotifier.updatePaymentId(paymentResponse.paymentId.toString());
        }

        if (context.mounted) {
          context.push(AppRoutes.paymentInit, extra: {
            'paymentUrl': paymentResponse.paymentUrl!,
            'orderId': paymentResponse.orderId ?? '',
          });
        }
      } else {
        throw ApiException(
            message: paymentResponse.message ??
                'Не удалось получить ссылку на оплату');
      }
    } on ApiException catch (e) {
      debugPrint('Ошибка API при оформлении заказа: ${e.message}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: ${e.message}')),
        );
      }
    } catch (e, st) {
      debugPrint('Неизвестная ошибка при оформлении заказа: $e\n$st');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Произошла неизвестная ошибка')),
        );
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>(
    (ref) => OrderNotifier(ref));
