// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Favorite _$FavoriteFromJson(Map<String, dynamic> json) => _Favorite(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      type: json['type'] as String,
      dateStart: json['date_start'] as String,
      dateEnd: json['date_end'] as String,
      image: json['image'] as String?,
      address: json['address'] as String?,
      direction: json['direction'] == null
          ? null
          : Direction.fromJson(json['direction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteToJson(_Favorite instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'date_start': instance.dateStart,
      'date_end': instance.dateEnd,
      'image': instance.image,
      'address': instance.address,
      'direction': instance.direction,
    };
