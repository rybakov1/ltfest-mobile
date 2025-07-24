// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageData _$ImageDataFromJson(Map<String, dynamic> json) => _ImageData(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      mime: json['mime'] as String,
      formats: json['formats'] == null
          ? null
          : ImageFormats.fromJson(json['formats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageDataToJson(_ImageData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'mime': instance.mime,
      'formats': instance.formats,
    };

_ImageFormats _$ImageFormatsFromJson(Map<String, dynamic> json) =>
    _ImageFormats(
      thumbnail: json['thumbnail'] == null
          ? null
          : ImageFormat.fromJson(json['thumbnail'] as Map<String, dynamic>),
      small: json['small'] == null
          ? null
          : ImageFormat.fromJson(json['small'] as Map<String, dynamic>),
      medium: json['medium'] == null
          ? null
          : ImageFormat.fromJson(json['medium'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageFormatsToJson(_ImageFormats instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'small': instance.small,
      'medium': instance.medium,
    };

_ImageFormat _$ImageFormatFromJson(Map<String, dynamic> json) => _ImageFormat(
      url: json['url'] as String,
    );

Map<String, dynamic> _$ImageFormatToJson(_ImageFormat instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
