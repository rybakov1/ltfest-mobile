// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ltstory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LTStory _$LTStoryFromJson(Map<String, dynamic> json) => _LTStory(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      url: json['url'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => ImageData.fromJson(e as Map<String, dynamic>))
          .toList(),
      preview: json['preview'] == null
          ? null
          : ImageData.fromJson(json['preview'] as Map<String, dynamic>),
      direction: json['direction'] == null
          ? null
          : Direction.fromJson(json['direction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LTStoryToJson(_LTStory instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'media': instance.media,
      'preview': instance.preview,
      'direction': instance.direction,
    };
