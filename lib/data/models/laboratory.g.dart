// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Laboratory _$LaboratoryFromJson(Map<String, dynamic> json) => _Laboratory(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] == null
          ? null
          : ImageData.fromJson(json['image'] as Map<String, dynamic>),
      description: json['description'] as String?,
      address: json['address'] as String?,
      direction: Direction.fromJson(json['direction'] as Map<String, dynamic>),
      persons: (json['persons'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      learningTypes: (json['learning_types'] as List<dynamic>?)
          ?.map((e) => LearningType.fromJson(e as Map<String, dynamic>))
          .toList(),
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => LaboratoryDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LaboratoryToJson(_Laboratory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'description': instance.description,
      'address': instance.address,
      'direction': instance.direction,
      'persons': instance.persons,
      'learning_types': instance.learningTypes,
      'days': instance.days,
    };
