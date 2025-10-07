// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductMaterial _$ProductMaterialFromJson(Map<String, dynamic> json) =>
    _ProductMaterial(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$ProductMaterialToJson(_ProductMaterial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

_ProductColor _$ProductColorFromJson(Map<String, dynamic> json) =>
    _ProductColor(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      hex: json['hex'] as String?,
    );

Map<String, dynamic> _$ProductColorToJson(_ProductColor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'hex': instance.hex,
    };

_ProductSize _$ProductSizeFromJson(Map<String, dynamic> json) => _ProductSize(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$ProductSizeToJson(_ProductSize instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
