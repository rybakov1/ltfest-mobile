// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      id: (json['id'] as num).toInt(),
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      residence: json['residence'] as String?,
      phone: json['phone'] as String?,
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      direction: json['direction'] == null
          ? null
          : Direction.fromJson(json['direction'] as Map<String, dynamic>),
      collectiveName: json['collectiveName'] as String?,
      collectiveCity: json['collectiveCity'] as String?,
      ltpriority: json['ltpriority'] as String?,
      educationPlace: json['educationPlace'] as String?,
      masterName: json['masterName'] as String?,
      favouritesFestivals: (json['favourites_festivals'] as List<dynamic>?)
              ?.map((e) => Festival.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      favouritesLaboratories:
          (json['favourites_laboratories'] as List<dynamic>?)
                  ?.map((e) => Laboratory.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'birthdate': instance.birthdate?.toIso8601String(),
      'residence': instance.residence,
      'phone': instance.phone,
      'activity': instance.activity,
      'direction': instance.direction,
      'collectiveName': instance.collectiveName,
      'collectiveCity': instance.collectiveCity,
      'ltpriority': instance.ltpriority,
      'educationPlace': instance.educationPlace,
      'masterName': instance.masterName,
      'favourites_festivals': instance.favouritesFestivals,
      'favourites_laboratories': instance.favouritesLaboratories,
    };
