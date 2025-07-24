// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ltbanner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LTBanner _$LTBannerFromJson(Map<String, dynamic> json) => _LTBanner(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      url: json['url'] as String?,
      image: json['image'] == null
          ? null
          : ImageData.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LTBannerToJson(_LTBanner instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'image': instance.image,
    };
