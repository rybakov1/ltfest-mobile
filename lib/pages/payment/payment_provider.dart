import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/payment.dart';

/// Провайдер теперь объявляется вручную.
final paymentNotifierProvider =
    StateNotifierProvider<PaymentNotifier, AsyncValue<PaymentState>>(
  (ref) {
    return PaymentNotifier();
  },
);

/// Notifier теперь наследуется от StateNotifier.
class PaymentNotifier extends StateNotifier<AsyncValue<PaymentState>> {
  PaymentNotifier()
      : super(const AsyncData(PaymentState(status: PaymentStatus.initial)));

  /// Этот метод позволяет безопасно обновить состояние извне.
  void setState(AsyncValue<PaymentState> newState) {
    if (mounted) {
      state = newState;
    }
  }

  /// Метод для простого обновления paymentId.
  /// Он нужен для резервного механизма в GoRouter.
  void updatePaymentId(String paymentId) {
    if (mounted) {
      final currentState =
          state.value ?? const PaymentState(status: PaymentStatus.initial);
      state = AsyncData(currentState.copyWith(paymentId: paymentId));
    }
  }

  /// Метод для сброса состояния.
  void resetState() {
    if (mounted) {
      state = const AsyncData(PaymentState(status: PaymentStatus.initial));
    }
  }
}
