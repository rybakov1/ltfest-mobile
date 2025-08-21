// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_festival.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteFestival _$FavoriteFestivalFromJson(Map<String, dynamic> json) =>
    _FavoriteFestival(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      address: json['address'] as String?,
      price: (json['price'] as num).toInt(),
      dateStart: json['date_start'] == null
          ? null
          : DateTime.parse(json['date_start'] as String),
      dateEnd: json['date_end'] == null
          ? null
          : DateTime.parse(json['date_end'] as String),
      description: json['description'] as String?,
      pdfurl: json['pdfurl'] as String?,
      entryurl: json['entryurl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$FavoriteFestivalToJson(_FavoriteFestival instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'address': instance.address,
      'price': instance.price,
      'date_start': instance.dateStart?.toIso8601String(),
      'date_end': instance.dateEnd?.toIso8601String(),
      'description': instance.description,
      'pdfurl': instance.pdfurl,
      'entryurl': instance.entryurl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'publishedAt': instance.publishedAt.toIso8601String(),
    };
