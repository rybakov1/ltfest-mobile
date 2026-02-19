import 'dart:math';
import 'package:ltfest/data/models/promocode.dart';

import '../entities/order_info.dart';

class CalculateTotalPrice {
  int execute({
    required OrderInfo order,
    PromoCode? promoCode,
  }) {
    final int basePrice = _calculateBasePrice(order);
    final int serviceFee = _calculateServiceFee(order);
    final int discountAmount = _calculateDiscount(
      basePrice: basePrice,
      promoCode: promoCode,
    );

    final int total = (basePrice - discountAmount) + serviceFee;
    return total;
  }

  int calculateBasePrice(OrderInfo order) {
    return _calculateBasePrice(order);
  }

  int calculateServiceFee(OrderInfo order) {
    return _calculateServiceFee(order);
  }

  int _calculateBasePrice(OrderInfo order) {
    return switch (order) {
      FestivalOrder o => _getFestivalBase(o),
      LaboratoryOrder o => o.learningType.price * o.seatCount,
      ProductOrder o => o.items.fold(
          0,
          (sum, item) =>
              sum + (item.productInStock?.price ?? 0) * item.quantity),
    };
  }

  int _getFestivalBase(FestivalOrder o) {
    final tariff = o.festivalTariff;
    if (tariff.fact_price != null) {
      return tariff.fact_price!.toInt() * o.seatCount;
    }
    return (tariff.price ~/ 2) * o.seatCount;
  }

  int _calculateServiceFee(OrderInfo order) {
    return switch (order) {
      FestivalOrder o => 990 * o.seatCount,
      LaboratoryOrder o => 550 * o.seatCount,
      ProductOrder o =>
        o.items.fold(0, (sum, item) => sum + (99 * item.quantity)),
    };
  }

  int _calculateDiscount({
    required int basePrice,
    PromoCode? promoCode,
  }) {
    double totalDiscount = 0;

    if (promoCode != null) {
      if (promoCode.discountType == 'percentage') {
        totalDiscount = basePrice * (promoCode.discountValue / 100);
      } else {
        totalDiscount = promoCode.discountValue.toDouble();
      }
    }

    return min(totalDiscount.round(), basePrice);
  }
}
