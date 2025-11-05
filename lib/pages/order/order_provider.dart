// lib/pages/order/order_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/providers/user_provider.dart';
import 'package:ltfest/router/app_routes.dart';

enum DeliveryMethod { onFestival, cdek }
enum OrderType { products, festival, laboratory, ltpriority }

@immutable
class OrderState {
  final OrderType orderType;

  final String payerName;
  final String email;
  final String phone;
  final String collectiveName;
  final DeliveryMethod deliveryMethod;
  final Festival? selectedFestival;
  final String deliveryAddress;
  final bool isLoading;

  const OrderState({
    this.payerName = '',
    this.email = '',
    this.phone = '',
    this.collectiveName = '',
    this.deliveryMethod = DeliveryMethod.onFestival,
    this.selectedFestival,
    this.deliveryAddress = '',
    this.isLoading = false,
    this.orderType = OrderType.products,
  });

  OrderState copyWith({
    String? payerName,
    String? email,
    String? phone,
    String? collectiveName,
    DeliveryMethod? deliveryMethod,
    Festival? selectedFestival,
    String? deliveryAddress,
    bool? isLoading,
    OrderType? orderType,
  }) {
    return OrderState(
      payerName: payerName ?? this.payerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      collectiveName: collectiveName ?? this.collectiveName,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      // Если меняется метод доставки, сбрасываем связанные с ним поля
      selectedFestival:
          deliveryMethod != null && deliveryMethod != DeliveryMethod.onFestival
              ? null
              : selectedFestival ?? this.selectedFestival,
      deliveryAddress:
          deliveryMethod != null && deliveryMethod != DeliveryMethod.cdek
              ? ''
              : deliveryAddress ?? this.deliveryAddress,
      isLoading: isLoading ?? this.isLoading,
      orderType: orderType ?? this.orderType,
    );
  }
}

// Провайдер для фестивалей (чтобы не зависеть от категории)
final allFestivalsProvider = FutureProvider<List<Festival>>((ref) {
  return ref.watch(apiServiceProvider).getFestivals();
});

// Notifier для управления состоянием заказа
class OrderNotifier extends StateNotifier<OrderState> {
  final Ref _ref;

  OrderNotifier(this._ref) : super(const OrderState()) {
    _prefillUserData();
  }

  // Предзаполнение данных из профиля пользователя
  void _prefillUserData() {
    // Используем наш новый, удобный userProvider!
    final user = _ref.read(userProvider);

    // Проверяем, что пользователь не null (т.е. он авторизован)
    if (user != null) {
      state = state.copyWith(
        payerName: (user.lastname ?? '').trim(),
        email: user.email,
        phone: user.phone,
        collectiveName: user.collectiveName,
      );
    }
  }

  void setOrderType(OrderType type) {
    state = state.copyWith(orderType: type);
  }

  void reset(OrderType type) {
    // Сначала сбросим всё
    state = const OrderState();
    // Затем установим тип и заполним пользователя
    setOrderType(type);
    _prefillUserData();
  }

  void updatePayerName(String value) =>
      state = state.copyWith(payerName: value);

  void updateEmail(String value) => state = state.copyWith(email: value);

  void updatePhone(String value) => state = state.copyWith(phone: value);

  void updateCollectiveName(String value) =>
      state = state.copyWith(collectiveName: value);

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

  Future<void> placeOrderAndPay(BuildContext context) async {
    try {
      final totalAmount = _ref.read(cartTotalPriceProvider);
      final orderId = 'LTFEST_${DateTime.now().millisecondsSinceEpoch}';

      final paymentData = {
        'amount': totalAmount, // Сумма в копейках
        'orderId': orderId,
        'description': 'Оплата заказа №$orderId',
        'email': state.email,
      };
      if (context.mounted) {
        context.push(AppRoutes.paymentInit, extra: paymentData);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка при подготовке к оплате: $e')));
      }
    }
  }
}


final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>(
    (ref) => OrderNotifier(ref));
