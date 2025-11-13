// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_tariff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FestivalTariff _$FestivalTariffFromJson(Map<String, dynamic> json) =>
    _FestivalTariff(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      fact_price: (json['fact_price'] as num?)?.toDouble(),
      price_description: json['price_description'] as String?,
      feature: (json['feature'] as List<dynamic>)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FestivalTariffToJson(_FestivalTariff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'fact_price': instance.fact_price,
      'price_description': instance.price_description,
      'feature': instance.feature,
    };
