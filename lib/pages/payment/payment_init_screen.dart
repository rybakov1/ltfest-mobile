import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentInitScreen extends ConsumerStatefulWidget {
  final String paymentUrl;
  final String orderId;

  const PaymentInitScreen({
    super.key,
    required this.paymentUrl,
    required this.orderId,
  });

  @override
  ConsumerState<PaymentInitScreen> createState() => _PaymentInitScreenState();
}

class _PaymentInitScreenState extends ConsumerState<PaymentInitScreen> {
  bool _browserOpened = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchPaymentBrowser();
    });
  }

  Future<void> _launchPaymentBrowser() async {
    if (_browserOpened) return;
    _browserOpened = true;

    try {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось открыть страницу оплаты: $e')),
        );
      }
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
              'Перенаправляем на страницу оплаты...',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
