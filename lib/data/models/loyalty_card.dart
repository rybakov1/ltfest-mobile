import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/user.dart';

part 'loyalty_card.freezed.dart';
part 'loyalty_card.g.dart';

@freezed
abstract class LoyaltyCard with _$LoyaltyCard {
  const factory LoyaltyCard({
    required int id,
    required String cardStatus,
    required DateTime validFrom,
    required DateTime validUntil,
    required String cardNumber,
    required int discountPercent,
    required User user,
  }) = _LoyaltyCard;

  factory LoyaltyCard.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyCardFromJson(json);
}