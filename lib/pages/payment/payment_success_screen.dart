// lib/pages/payment/payment_success_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/payment.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/payment/payment_failure_screen.dart';
import 'package:ltfest/pages/payment/payment_provider.dart';
import 'package:ltfest/pages/shop/presenter/shop_widget.dart';
import 'package:ltfest/router/app_routes.dart';

class PaymentSuccessScreen extends ConsumerStatefulWidget {
  final String paymentId;

  const PaymentSuccessScreen({super.key, required this.paymentId});

  @override
  ConsumerState<PaymentSuccessScreen> createState() =>
      _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends ConsumerState<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkPaymentStatus();
      }
    });
  }

  /// Логика проверки статуса платежа теперь здесь.
  Future<void> _checkPaymentStatus() async {
    final notifier = ref.read(paymentNotifierProvider.notifier);
    final apiService = ref.read(apiServiceProvider);

    notifier.setState(const AsyncLoading());

    try {
      print("in widget id is ${widget.paymentId}");

      final response = await apiService.getPaymentState(widget.paymentId);

      if (!mounted) return;

      if (response.success) {
        if (response.status == 'AUTHORIZED') {
          await apiService.confirmPayment(widget.paymentId);
          notifier.setState(AsyncData(PaymentState(
              status: PaymentStatus.success, paymentId: widget.paymentId)));
        } else if (response.status == 'CONFIRMED') {
          notifier.setState(AsyncData(PaymentState(
              status: PaymentStatus.success, paymentId: widget.paymentId)));
        } else {
          throw Exception('Статус платежа: ${response.status ?? "неизвестен"}');
        }
      } else {
        throw Exception(response.message ?? 'Ошибка проверки статуса платежа');
      }
    } catch (e, st) {
      if (!mounted) return;
      notifier.setState(AsyncError(e, st));
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentAsync = ref.watch(paymentNotifierProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      body: paymentAsync.when(
        data: (state) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: Decor.base.copyWith(
                color: Palette.background,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(28),
                  bottomLeft: Radius.circular(28),
                ),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Заявка успешно оформлена!',
                    style: Styles.h4,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24),
                      child: Column(
                        children: [
                          Text(
                            'Вам также может понравиться',
                            style: Styles.b1.copyWith(color: Palette.gray),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          const ShopWidget(),
                          const Spacer(),
                          LTButtons.outlinedButton(
                            onPressed: () {
                              ref.read(cartProvider.notifier).clearCart();
                              ref
                                  .read(paymentNotifierProvider.notifier)
                                  .resetState();
                              context.go(AppRoutes.home);
                            },
                            child: Text('Закрыть!', style: Styles.button1),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        loading: () => const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Подтверждаем оплату...'),
          ],
        ),
        error: (err, stack) =>
            PaymentFailureScreen(paymentId: widget.paymentId),
      ),
    );
  }
}
