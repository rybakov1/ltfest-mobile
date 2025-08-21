// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_laboratory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteLaboratory _$FavoriteLaboratoryFromJson(Map<String, dynamic> json) =>
    _FavoriteLaboratory(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      address: json['address'] as String?,
      url: json['url'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$FavoriteLaboratoryToJson(_FavoriteLaboratory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'url': instance.url,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'publishedAt': instance.publishedAt.toIso8601String(),
    };
