// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory_learning_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LearningType _$LearningTypeFromJson(Map<String, dynamic> json) =>
    _LearningType(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      price: (json['price'] as num).toInt(),
      dateInfo: json['date_info'] as String?,
      location: json['location'] as String?,
      duration: json['duration'] as String?,
      certificate: json['certificate'] as String?,
    );

Map<String, dynamic> _$LearningTypeToJson(_LearningType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'price': instance.price,
      'date_info': instance.dateInfo,
      'location': instance.location,
      'duration': instance.duration,
      'certificate': instance.certificate,
    };
