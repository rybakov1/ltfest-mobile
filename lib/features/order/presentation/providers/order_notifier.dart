import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/data/models/festival_tariff.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/data/models/laboratory_learning_type.dart';

import '../../../../data/api/api_client.dart';
import '../../../../data/models/festival.dart';
import '../../../../data/repositories/misc_repository.dart';
import '../../../../pages/cart/provider/cart_provider.dart';
import '../../../../pages/payment/payment_provider.dart';
import '../../../../providers/promocode_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../router/app_routes.dart';
import '../../data/repositories/strapi_order_repository.dart';
import '../../domain/entities/order_enums.dart';
import '../../domain/entities/order_info.dart';
import '../../domain/repositories/i_order_repository.dart';
import 'order_state.dart';

OrderInfo? buildOrderEntityFromState({
  required OrderState state,
  required Ref ref,
}) {
  final user = ref.read(userProvider);
  final userId = user?.id;

  final promoState = ref.read(promoCodeNotifierProvider);
  final activePromoCode = promoState.maybeMap(
    success: (s) => s.promoCode.code,
    orElse: () => null,
  );

  switch (state.orderType) {
    case OrderType.products:
      final cartState = ref.read(cartProvider);
      if (cartState.value?.items == null || cartState.value!.items.isEmpty) {
        return null;
      }
      return ProductOrder(
        payerName: state.payerName,
        email: state.email,
        phone: state.phone,
        collectiveName: state.collectiveName,
        userId: userId,
        promoCode: activePromoCode,
        items: cartState.value!.items,
        deliveryMethod: state.deliveryMethod,
        address: state.deliveryAddress,
        selectedFestival: state.selectedFestival,
      );

    case OrderType.festival:
      if (state.selectedFestival == null ||
          state.payableItem is! FestivalTariff) {
        return null;
      }
      return FestivalOrder(
        payerName: state.payerName,
        email: state.email,
        phone: state.phone,
        collectiveName: state.collectiveName,
        userId: userId,
        promoCode: activePromoCode,
        festival: state.selectedFestival!,
        festivalTariff: state.payableItem as FestivalTariff,
        seatCount: state.seatCount,
        participantNames: state.participantNames,
      );

    case OrderType.laboratory:
      if (state.laboratory == null || state.payableItem is! LearningType) {
        return null;
      }
      return LaboratoryOrder(
        payerName: state.payerName,
        email: state.email,
        phone: state.phone,
        collectiveName: state.collectiveName,
        userId: userId,
        promoCode: activePromoCode,
        laboratory: state.laboratory!,
        learningType: state.payableItem as LearningType,
        seatCount: state.seatCount,
        birthdate: state.birthdate,
        residence: state.residence,
        collectiveInfo: state.collectiveInfo,
        education: state.education,
      );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  final Ref _ref;
  final IOrderRepository _repository;

  OrderNotifier(this._ref, this._repository) : super(const OrderState()) {
    prefillUserData();
  }

  void startOrder({
    required OrderType type,
    required dynamic item,
    Festival? festival,
    Laboratory? laboratory,
  }) {
    state = const OrderState().copyWith(
      orderType: type,
      payableItem: item,
      seatCount: 1,
      selectedFestival: festival,
      laboratory: laboratory,
    );
    prefillUserData();
  }

  void prefillUserData() {
    final user = _ref.read(userProvider);
    if (user != null) {
      String formattedBirthDate = '';
      try {
        if (user.birthdate != null) {
          final DateTime parsedDate =
              DateTime.parse(user.birthdate.toString().split(" ")[0]);
          formattedBirthDate = DateFormat('dd.MM.yyyy').format(parsedDate);
        }
      } catch (e) {
        debugPrint('Ошибка парсинга даты рождения: $e');
      }

      state = state.copyWith(
        payerName: (user.lastname ?? '').trim(),
        email: user.email ?? '',
        phone: user.phone ?? '',
        birthdate: formattedBirthDate,
        residence: user.residence ?? '',
        collectiveName: user.collectiveName ?? '',
      );
    }
  }

  void reset(OrderType type) {
    state = const OrderState();
    state = state.copyWith(orderType: type);
    prefillUserData();
  }

  void updatePayerName(String value) =>
      state = state.copyWith(payerName: value);
  void updateEmail(String value) => state = state.copyWith(email: value);
  void updateBirthdate(String value) =>
      state = state.copyWith(birthdate: value);
  void updateResidence(String value) =>
      state = state.copyWith(residence: value);
  void updatePhone(String value) => state = state.copyWith(phone: value);
  void updateCollectiveName(String value) =>
      state = state.copyWith(collectiveName: value);
  void updateParticipantNames(String value) =>
      state = state.copyWith(participantNames: value);
  void updateSeatCount(int value) => state = state.copyWith(seatCount: value);
  void updateDeliveryAddress(String value) =>
      state = state.copyWith(deliveryAddress: value);
  void updateCollectiveInfo(String value) =>
      state = state.copyWith(collectiveInfo: value);
  void updateEducation(String value) =>
      state = state.copyWith(education: value);

  void selectFestival(Festival festival) =>
      state = state.copyWith(selectedFestival: festival);

  void setDeliveryMethod(DeliveryMethod method) {
    if (method == DeliveryMethod.onFestival) {
      state = state.copyWith(deliveryMethod: method, deliveryAddress: '');
    } else {
      state = state.copyWith(deliveryMethod: method, selectedFestival: null);
    }
  }

  OrderInfo? _buildOrderEntity() =>
      buildOrderEntityFromState(state: state, ref: _ref);

  Future<void> placeOrderAndPay(
      BuildContext context, int totalAmount, int basePrice) async {
    if (state.isLoading) return;

    final orderEntity = _buildOrderEntity();
    if (orderEntity == null) {
      _showError(context, 'Недостаточно данных для оформления заказа');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final promoState = _ref.read(promoCodeNotifierProvider);
      await promoState.whenOrNull(
        success: (promoCode) async {
          await _ref.read(miscRepositoryProvider).applyPromoCode(promoCode);
        },
      );

      final response = await _repository.createPayment(
        order: orderEntity,
        totalAmount: totalAmount,
      );

      if (response.success && response.paymentUrl != null) {
        if (response.paymentId != null) {
          _ref
              .read(paymentNotifierProvider.notifier)
              .updatePaymentId(response.paymentId!);
        }

        if (context.mounted) {
          context.push(AppRoutes.paymentInit, extra: {
            'paymentUrl': response.paymentUrl!,
            'orderId': response.orderId ?? '',
            'paymentId': response.paymentId ?? '',
          });
        }
      } else {
        throw Exception(
            response.message ?? 'Не удалось получить ссылку на оплату');
      }
    } catch (e, st) {
      debugPrint('Ошибка оформления заказа: $e\n$st');
      state = state.copyWith(errorMessage: e.toString());
      if (context.mounted) {
        _showError(context, e.toString());
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ошибка: $message')),
    );
  }
}

final orderRepositoryProvider = Provider<IOrderRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return StrapiOrderRepository(client);
});

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return OrderNotifier(ref, repository);
});
