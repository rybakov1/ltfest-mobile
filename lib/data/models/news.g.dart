// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_News _$NewsFromJson(Map<String, dynamic> json) => _News(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      image: json['image'] as String?,
      url: json['url'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$NewsToJson(_News instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'image': instance.image,
      'url': instance.url,
      'description': instance.description,
    };
