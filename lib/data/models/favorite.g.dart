// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Favorite _$FavoriteFromJson(Map<String, dynamic> json) => _Favorite(
      id: (json['id'] as num).toInt(),
      favoriteId: (json['favoriteId'] as num).toInt(),
      type: json['type'] as String,
      title: json['title'] as String,
      image: json['image'] as String?,
      date_start: json['date_start'] as String?,
      date_end: json['date_end'] as String?,
      address: json['address'] as String?,
      direction: json['direction'] == null
          ? null
          : Direction.fromJson(json['direction'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      article: json['article'] as String?,
    );

Map<String, dynamic> _$FavoriteToJson(_Favorite instance) => <String, dynamic>{
      'id': instance.id,
      'favoriteId': instance.favoriteId,
      'type': instance.type,
      'title': instance.title,
      'image': instance.image,
      'date_start': instance.date_start,
      'date_end': instance.date_end,
      'address': instance.address,
      'direction': instance.direction,
      'price': instance.price,
      'article': instance.article,
    };
