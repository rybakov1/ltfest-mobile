// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_tariff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PriorityTariff _$PriorityTariffFromJson(Map<String, dynamic> json) =>
    _PriorityTariff(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      features: (json['features'] as List<dynamic>)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriorityTariffToJson(_PriorityTariff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'features': instance.features,
    };
