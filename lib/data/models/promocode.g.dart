// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promocode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PromoCode _$PromoCodeFromJson(Map<String, dynamic> json) => _PromoCode(
      id: (json['id'] as num).toInt(),
      documentId: json['documentId'] as String,
      description: json['description'] as String,
      code: json['code'] as String,
      discountType: json['discountType'] as String,
      discountValue: (json['discountValue'] as num).toDouble(),
      maxUses: (json['maxUses'] as num).toInt(),
      currentUses: (json['currentUses'] as num).toInt(),
      validUntil: DateTime.parse(json['validUntil'] as String),
    );

Map<String, dynamic> _$PromoCodeToJson(_PromoCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentId': instance.documentId,
      'description': instance.description,
      'code': instance.code,
      'discountType': instance.discountType,
      'discountValue': instance.discountValue,
      'maxUses': instance.maxUses,
      'currentUses': instance.currentUses,
      'validUntil': instance.validUntil.toIso8601String(),
    };
