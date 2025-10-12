// lib/pages/payment/payment_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/payment.dart';

/// Провайдер теперь объявляется вручную.
final paymentNotifierProvider =
    StateNotifierProvider<PaymentNotifier, AsyncValue<PaymentState>>((ref) {
  return PaymentNotifier();
});

/// Notifier теперь наследуется от StateNotifier.
class PaymentNotifier extends StateNotifier<AsyncValue<PaymentState>> {
  PaymentNotifier()
      : super(const AsyncData(PaymentState(status: PaymentStatus.initial)));

  void setState(AsyncValue<PaymentState> newState) {
    if (mounted) {
      state = newState;
    }
  }

  // Метод для сброса состояния.
  void resetState() {
    if (mounted) {
      state = const AsyncData(PaymentState(status: PaymentStatus.initial));
    }
  }
}
