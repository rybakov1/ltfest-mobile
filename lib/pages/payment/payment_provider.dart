import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/order/order_provider.dart';
import '../../data/models/payment.dart';

final paymentNotifierProvider =
    StateNotifierProvider<PaymentNotifier, AsyncValue<PaymentState>>(
  (ref) {
    return PaymentNotifier(ref);
  },
);

class PaymentNotifier extends StateNotifier<AsyncValue<PaymentState>> {
  final Ref _ref;

  PaymentNotifier(this._ref)
      : super(const AsyncData(PaymentState(status: PaymentStatus.initial)));

  void setState(AsyncValue<PaymentState> newState) {
    if (mounted) {
      state = newState;
    }
  }

  void updatePaymentId(String paymentId) {
    if (mounted) {
      final currentState =
          state.value ?? const PaymentState(status: PaymentStatus.initial);
      state = AsyncData(currentState.copyWith(paymentId: paymentId));
    }
  }

  void resetState() {
    if (mounted) {
      state = const AsyncData(PaymentState(status: PaymentStatus.initial));
    }
  }

  Future<void> handleOrderFulfillment(String paymentId) async {
    final apiService = _ref.read(apiServiceProvider);
    final orderNotifier = _ref.read(orderProvider.notifier);

    final lastOrderType = _ref.read(orderProvider).orderType;

    if (lastOrderType == OrderType.products) {
      try {
        final cart = await apiService.getMyCart();

        for (final cartItem in cart.items) {
          if (cartItem.productInStock != null) {
            final productInStock = cartItem.productInStock!;
            final newQuantity =
                productInStock.stockQuantity - cartItem.quantity;

            if (newQuantity >= 0) {
              await apiService.updateProductInStockQuantity(
                productInStockDocumentId: productInStock.documentId!,
                newQuantity: newQuantity,
              );
            } else {
              debugPrint(
                  '[Fulfillment Error] Недостаточно товара ${productInStock.id} при подтверждении заказа!');
            }
          }
        }

        _ref.read(cartProvider.notifier).clearCart();
      } catch (e) {
        debugPrint('Ошибка фулфилмента заказа: $e');
      }
    }

    orderNotifier.reset(OrderType.products);
  }
}
