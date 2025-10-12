// lib/pages/payment/payment_failure_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/pages/payment/payment_provider.dart';
import 'package:ltfest/router/app_routes.dart';

class PaymentFailureScreen extends ConsumerWidget {
  final String paymentId;

  const PaymentFailureScreen({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Palette.error, size: 100),
              const SizedBox(height: 24),
              Text('Оплата не удалась',
                  style: Styles.h2.copyWith(color: Palette.error),
                  textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text(
                'Пожалуйста, попробуйте еще раз или выберите другой способ оплаты.',
                style: Styles.b1.copyWith(color: Palette.gray),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              LTButtons.elevatedButton(
                onPressed: () {
                  ref.read(paymentNotifierProvider.notifier).resetState();
                  context.go(AppRoutes.order);
                },
                child: Text('Попробовать снова', style: Styles.button1),
              ),
              const SizedBox(height: 16),
              LTButtons.elevatedButton(
                onPressed: () {
                  ref.read(paymentNotifierProvider.notifier).resetState();
                  context.go(AppRoutes.home); // Укажи свой главный маршрут
                },
                child: Text('Вернуться на главную',
                    style: Styles.button1.copyWith(color: Palette.gray)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
