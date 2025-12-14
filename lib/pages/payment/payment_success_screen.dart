import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/payment.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/order/order_provider.dart';
import 'package:ltfest/pages/payment/payment_failure_screen.dart';
import 'package:ltfest/pages/payment/payment_provider.dart';
import 'package:ltfest/pages/shop/presenter/shop_widget.dart';
import 'package:ltfest/pages/shop/presenter/shop_with_cart_widget.dart';
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
    if (widget.paymentId == '{PaymentId}') {
      debugPrint('Получен шаблон ID вместо реального ID. Пропускаем запрос.');

      // Попытка спасти ситуацию: берем ID из провайдера, если он там есть
      final savedId = ref.read(paymentNotifierProvider).value?.paymentId;
      if (savedId != null && savedId != '{PaymentId}') {
        // Рекурсивно вызываем проверку уже с нормальным ID (через навигацию или локально)
        // Но проще просто прервать текущий запрос, так как GoRouter
        // скорее всего уже перенаправляет нас на правильный ID следующим кадром.
      }
      return;
    }

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
          await notifier.handleOrderFulfillment(widget.paymentId);

          notifier.setState(AsyncData(PaymentState(
              status: PaymentStatus.success, paymentId: widget.paymentId)));
        } else if (response.status == 'CONFIRMED') {
          await notifier.handleOrderFulfillment(widget.paymentId);
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
    final orderState = ref.watch(orderProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      body: paymentAsync.when(
        data: (state) => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 64 + MediaQuery.of(context).padding.top),
                  Image.asset(
                    'assets/images/payment_success.png',
                    width: 101,
                  ),
                  const SizedBox(height: 16),
                  Text("Заявка успешно оформлена!",
                      style: Styles.h3, textAlign: TextAlign.center),
                  if (orderState.orderType == OrderType.laboratory) ...[
                    const SizedBox(height: 8),
                    Text(
                      "Cкоро свяжемся с вами, чтобы передать ссылку на просмотр",
                      textAlign: TextAlign.center,
                      style: Styles.b1,
                    ),
                    const SizedBox(height: 18),
                  ],
                  if (orderState.orderType != OrderType.laboratory) ...[
                    const SizedBox(height: 40),
                  ],
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24),
                    child: Column(
                      children: [
                        Text(
                          'Вам также может понравиться',
                          style: Styles.b1.copyWith(color: Palette.gray),
                          textAlign: TextAlign.center,
                        ),
                        const ShopWidget(),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 48),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 24,
                  right: 16,
                  left: 16,
                  top: 24,
                ),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Palette.white),
                child: LTButtons.outlinedButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).clearCart();
                    ref.read(paymentNotifierProvider.notifier).resetState();
                    context.go(AppRoutes.home);
                  },
                  child: Text('Закрыть', style: Styles.button1),
                ),
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
