// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Festival _$FestivalFromJson(Map<String, dynamic> json) => _Festival(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String?,
      price: (json['price'] as num).toInt(),
      date: json['date'] as String,
      address: json['address'] as String?,
      description: json['description'] as String?,
      pdfurl: json['pdfurl'] as String?,
      direction: Direction.fromJson(json['direction'] as Map<String, dynamic>),
      jury: (json['jury'] as List<dynamic>)
          .map((e) => Jury.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FestivalToJson(_Festival instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'price': instance.price,
      'date': instance.date,
      'address': instance.address,
      'description': instance.description,
      'pdfurl': instance.pdfurl,
      'direction': instance.direction,
      'jury': instance.jury,
    };
