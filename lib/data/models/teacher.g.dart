// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Teacher _$TeacherFromJson(Map<String, dynamic> json) => _Teacher(
      id: (json['id'] as num).toInt(),
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TeacherToJson(_Teacher instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'image': instance.image,
      'description': instance.description,
    };
