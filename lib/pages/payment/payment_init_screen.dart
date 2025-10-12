// lib/pages/payment/payment_init_screen.dart

import 'dart:async';

import '../../data/models/payment.dart';
import '../../data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/pages/payment/payment_provider.dart';

class PaymentInitScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> paymentData;

  const PaymentInitScreen({super.key, required this.paymentData});

  @override
  ConsumerState<PaymentInitScreen> createState() => _PaymentInitScreenState();
}

class _PaymentInitScreenState extends ConsumerState<PaymentInitScreen> {
  bool _browserOpened = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAndLaunchPayment();
    });
  }

  Future<void> openUrlInCustomTab(BuildContext context, String url) async {
    try {
      await launchUrl(
        Uri.parse(url),
        customTabsOptions: CustomTabsOptions(
          shareState: CustomTabsShareState.on,
          urlBarHidingEnabled: true,
          showTitle: true,
          closeButton:
              CustomTabsCloseButton(icon: CustomTabsCloseButtonIcons.back),
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      debugPrint('Failed to launch Custom Tab: $e');
    }
  }

  /// 2. Инициализация и запуск оплаты
  Future<void> _initAndLaunchPayment() async {
    if (_browserOpened) return;
    _browserOpened = true;

    final notifier = ref.read(paymentNotifierProvider.notifier);
    notifier.setState(const AsyncLoading());

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.initPayment(
        amount: widget.paymentData['amount'],
        orderId: widget.paymentData['orderId'],
        successUrl: 'ltfestapp://payment/success/{PaymentId}',
        failUrl: 'ltfestapp://payment/fail/{PaymentId}',
        description: widget.paymentData['description'],
        customerEmail: widget.paymentData['email'],
      );

      if (!mounted) return;

      if (response.success && response.paymentUrl != null) {
        final successState = PaymentState(
            status: PaymentStatus.ready,
            paymentUrl: response.paymentUrl,
            paymentId: response.paymentId);
        notifier.setState(AsyncData(successState));
        await openUrlInCustomTab(context, response.paymentUrl!);
      } else {
        throw Exception(response.message ?? 'Не удалось получить ссылку');
      }
    } catch (e, st) {
      if (!mounted) return;
      notifier.setState(AsyncError(e, st));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка создания платежа: $e')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Ожидание завершения оплаты...\nПожалуйста, вернитесь в приложение после оплаты.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
