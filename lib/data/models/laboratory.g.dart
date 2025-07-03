// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Laboratory _$LaboratoryFromJson(Map<String, dynamic> json) => _Laboratory(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      direction: Direction.fromJson(json['direction'] as Map<String, dynamic>),
      teachers: (json['teachers'] as List<dynamic>?)
          ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
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
      'teachers': instance.teachers,
      'learning_types': instance.learningTypes,
      'days': instance.days,
    };
