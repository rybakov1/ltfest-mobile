// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jury.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Jury _$JuryFromJson(Map<String, dynamic> json) => _Jury(
      id: (json['id'] as num).toInt(),
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$JuryToJson(_Jury instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'image': instance.image,
      'description': instance.description,
    };
