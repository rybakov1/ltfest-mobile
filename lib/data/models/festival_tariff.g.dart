// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_tariff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FestivalTariff _$FestivalTariffFromJson(Map<String, dynamic> json) =>
    _FestivalTariff(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
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
      'feature': instance.feature,
    };
