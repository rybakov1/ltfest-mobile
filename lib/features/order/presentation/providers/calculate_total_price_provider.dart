import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/services/api_service.dart';

import '../../../../providers/promocode_provider.dart';
import '../../domain/entities/order_info.dart';
import '../../domain/usecases/calculate_total_price.dart';
import 'order_notifier.dart';

final calculateTotalPriceUseCaseProvider =
    Provider((ref) => CalculateTotalPrice());

final allFestivalsProvider = FutureProvider<List<Festival>>((ref) {
  return ref.watch(apiServiceProvider).getFestivals();
});

/// Текущая доменная сущность заказа, собранная из состояния и зависимостей.
final currentOrderProvider = Provider<OrderInfo?>((ref) {
  final state = ref.watch(orderProvider);
  return buildOrderEntityFromState(state: state, ref: ref);
});

final orderBasePriceProvider = Provider<int>((ref) {
  final order = ref.watch(currentOrderProvider);

  if (order == null) return 0;

  final calculator = ref.watch(calculateTotalPriceUseCaseProvider);
  return calculator.calculateBasePrice(order);
});

final orderServiceFeeProvider = Provider<int>((ref) {
  final order = ref.watch(currentOrderProvider);

  if (order == null) return 0;

  final calculator = ref.watch(calculateTotalPriceUseCaseProvider);
  return calculator.calculateServiceFee(order);
});

final orderTotalPriceProvider = Provider<int>((ref) {
  final order = ref.watch(currentOrderProvider);

  if (order == null) return 0;

  final calculator = ref.watch(calculateTotalPriceUseCaseProvider);
  final promoState = ref.watch(promoCodeNotifierProvider);

  final activePromo = promoState.maybeMap(
    success: (s) => s.promoCode,
    orElse: () => null,
  );

  return calculator.execute(
    order: order,
    promoCode: activePromo,
  );
});