import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/router/app_routes.dart';

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

class _PaymentInitScreenState extends ConsumerState<PaymentInitScreen>
    with WidgetsBindingObserver {
  bool _browserOpened = false;
  bool _isNavigating = false;

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

    if (state == AppLifecycleState.resumed && _browserOpened && !_isNavigating) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && !_isNavigating) {
          debugPrint("Deep link not detected, navigating to failure screen.");
          _navigateToFailureScreen();
        }
      });
    }
  }

  void _navigateToFailureScreen() {
    if (mounted && !_isNavigating) {
      _isNavigating = true;
      context.go(AppRoutes.paymentFailure.replaceFirst(':id', widget.orderId));
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось открыть страницу оплаты: $e')),
        );
        _navigateToFailureScreen();
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
