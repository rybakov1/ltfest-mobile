import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/models/festival_tariff.dart';

import '../../../../data/models/laboratory.dart';
import '../../../../data/models/laboratory_learning_type.dart';
import '../../../../pages/cart/models/cart_item.dart';
import 'order_enums.dart';

sealed class OrderInfo {
  final String payerName;
  final String email;
  final String phone;
  final String collectiveName;
  final int? userId;
  final String? promoCode;

  OrderInfo({
    required this.payerName,
    required this.email,
    required this.phone,
    required this.collectiveName,
    this.userId,
    this.promoCode,
  });
}

class FestivalOrder extends OrderInfo {
  final Festival festival;
  final FestivalTariff festivalTariff;
  final int seatCount;
  final String participantNames;

  FestivalOrder({
    required super.payerName,
    required super.email,
    required super.phone,
    required super.collectiveName,
    super.userId,
    super.promoCode,
    required this.festival,
    required this.festivalTariff,
    required this.seatCount,
    required this.participantNames,
  });
}

class LaboratoryOrder extends OrderInfo {
  final Laboratory laboratory;
  final LearningType learningType;
  final int seatCount;
  final String birthdate;
  final String residence;
  final String collectiveInfo;
  final String education;

  LaboratoryOrder({
    required super.payerName,
    required super.email,
    required super.phone,
    required super.collectiveName,
    super.userId,
    super.promoCode,
    required this.laboratory,
    required this.learningType,
    required this.seatCount,
    required this.birthdate,
    required this.residence,
    required this.collectiveInfo,
    required this.education,
  });
}

class ProductOrder extends OrderInfo {
  final List<CartItem> items;
  final DeliveryMethod deliveryMethod;
  final String? address;
  final Festival? selectedFestival;

  ProductOrder({
    required super.payerName,
    required super.email,
    required super.phone,
    required super.collectiveName,
    super.userId,
    super.promoCode,
    required this.items,
    required this.deliveryMethod,
    this.address,
    this.selectedFestival,
  });
}
