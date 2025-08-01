// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Festival _$FestivalFromJson(Map<String, dynamic> json) => _Festival(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] == null
          ? null
          : ImageData.fromJson(json['image'] as Map<String, dynamic>),
      price: (json['price'] as num).toInt(),
      dateStart: json['date_start'] == null
          ? null
          : DateTime.parse(json['date_start'] as String),
      dateEnd: json['date_end'] == null
          ? null
          : DateTime.parse(json['date_end'] as String),
      address: json['address'] as String?,
      description: json['description'] as String?,
      pdfurl: json['pdfurl'] as String?,
      entryurl: json['entryurl'] as String?,
      direction: Direction.fromJson(json['direction'] as Map<String, dynamic>),
      persons: (json['persons'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FestivalToJson(_Festival instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'price': instance.price,
      'date_start': instance.dateStart?.toIso8601String(),
      'date_end': instance.dateEnd?.toIso8601String(),
      'address': instance.address,
      'description': instance.description,
      'pdfurl': instance.pdfurl,
      'entryurl': instance.entryurl,
      'direction': instance.direction,
      'persons': instance.persons,
    };
