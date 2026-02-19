import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/laboratory_learning_type.dart';
import 'package:ltfest/pages/payment/payment_provider.dart';
import 'package:ltfest/router/app_routes.dart';

import '../../data/models/festival_order_args_model.dart';
import '../../data/models/festival_tariff.dart';
import '../../data/models/laboratory_order_args_model.dart';
import '../order/order_provider.dart';

class PaymentFailureScreen extends ConsumerWidget {
  final String paymentId;

  const PaymentFailureScreen({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Expanded(
              child: Container(
                decoration: Decor.base,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/error_payment.png",
                          width: 178),
                      const SizedBox(height: 40),
                      Text('Что-то пошло не так..', style: Styles.h3),
                      const SizedBox(height: 24),
                      Text(
                        'Мы не смогли получить ваш платеж. Пожалуйста, оформите заявку снова',
                        style: Styles.b2.copyWith(color: Palette.gray),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: LTButtons.outlinedButton(
                              onPressed: () {
                                ref
                                    .read(orderProvider.notifier)
                                    .reset(OrderType.products);
                                ref
                                    .read(paymentNotifierProvider.notifier)
                                    .resetState();
                                context.go(AppRoutes.home);
                              },
                              child: Text('Закрыть', style: Styles.button1),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: LTButtons.elevatedButton(
                              onPressed: () {
                                final orderState = ref.read(orderProvider);

                                ref
                                    .read(paymentNotifierProvider.notifier)
                                    .resetState();

                                context.go(AppRoutes.home);

                                switch (orderState.orderType) {
                                  case OrderType.products:
                                    context.push('/order/products');
                                    break;
                                  case OrderType.festival:
                                    if (orderState.selectedFestival != null &&
                                        orderState.payableItem
                                        is FestivalTariff) {
                                      final args = FestivalOrderArgs(
                                        festival: orderState.selectedFestival!,
                                        tariff: orderState.payableItem
                                        as FestivalTariff,
                                      );
                                      context.push(AppRoutes.festivalOrder,
                                          extra: args);
                                    }
                                    break;

                                  case OrderType.laboratory:
                                    if (orderState.laboratory != null &&
                                        orderState.payableItem
                                        is LearningType) {
                                      final args = LaboratoryOrderArgsModel(
                                        laboratory: orderState.laboratory!,
                                        learningType: orderState.payableItem
                                        as LearningType,
                                      );
                                      context.push(AppRoutes.laboratoryOrder,
                                          extra: args);
                                    }
                                    break;
                                  // case OrderType.ltpriority:
                                  //   context.push(AppRoutes.priorityOrder,
                                  //       extra: orderState.payableItem);
                                  //   break;
                                }
                              },
                              child:
                                  Text('Оформить снова', style: Styles.button1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
