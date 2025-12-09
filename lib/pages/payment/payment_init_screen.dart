import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/router/app_routes.dart';

class PaymentInitScreen extends ConsumerStatefulWidget {
  final String paymentUrl;
  final String orderId;
  final String paymentId;

  const PaymentInitScreen({
    super.key,
    required this.paymentUrl,
    required this.orderId,
    required this.paymentId,
  });

  @override
  ConsumerState<PaymentInitScreen> createState() => _PaymentInitScreenState();
}

class _PaymentInitScreenState extends ConsumerState<PaymentInitScreen>
    with WidgetsBindingObserver {
  bool _browserOpened = false;
  bool _isCheckingStatus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchPaymentBrowser();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed && _browserOpened) {
      _checkPaymentStatusOnResume();
    }
  }

  Future<void> _checkPaymentStatusOnResume() async {
    if (!mounted || _isCheckingStatus) return;

    setState(() {
      _isCheckingStatus = true;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getPaymentState(widget.paymentId);

      if (!mounted) return;

      if (response.success &&
          (response.status == 'AUTHORIZED' || response.status == 'CONFIRMED')) {
        context
            .go(AppRoutes.paymentSuccess.replaceFirst(':id', widget.paymentId));
      } else {
        debugPrint('Статус платежа при возврате: ${response.status}');
        if (mounted) {
          context
              .go(AppRoutes.paymentFailure.replaceFirst(':id', widget.paymentId));
        }
      }
    } catch (e) {
      debugPrint('Ошибка проверки статуса: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingStatus = false;
        });
      }
    }
  }

  Future<void> _launchPaymentBrowser() async {
    if (_browserOpened) return;
    try {
      _browserOpened = true;
      await launchUrl(
        Uri.parse(widget.paymentUrl),
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
      debugPrint('Не удалось запустить Custom Tab: $e');
      if (mounted) {
        context
            .go(AppRoutes.paymentFailure.replaceFirst(':id', widget.paymentId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text(
              'Ожидаем подтверждения оплаты...',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _checkPaymentStatusOnResume,
              child: const Text("Я оплатил, проверить статус"),
            )
          ],
        ),
      ),
    );
  }
}
