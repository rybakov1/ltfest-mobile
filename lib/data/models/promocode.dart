import 'package:freezed_annotation/freezed_annotation.dart';

part 'promocode.freezed.dart';
part 'promocode.g.dart';

@freezed
abstract class PromoCode with _$PromoCode {
  const factory PromoCode({
    required int id,
    required String documentId,
    required String description,
    required String code,
    required String discountType,
    required double discountValue,
    required int maxUses,
    required int currentUses,
    required DateTime validUntil,
  }) = _PromoCode;

  factory PromoCode.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeFromJson(json);
}
