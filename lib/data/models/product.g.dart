// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductSize _$ProductSizeFromJson(Map<String, dynamic> json) => _ProductSize(
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ProductSizeToJson(_ProductSize instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

_ProductColor _$ProductColorFromJson(Map<String, dynamic> json) =>
    _ProductColor(
      title: json['title'] as String?,
      hex: json['hex'] as String?,
    );

Map<String, dynamic> _$ProductColorToJson(_ProductColor instance) =>
    <String, dynamic>{
      'title': instance.title,
      'hex': instance.hex,
    };

_ProductMaterial _$ProductMaterialFromJson(Map<String, dynamic> json) =>
    _ProductMaterial(
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ProductMaterialToJson(_ProductMaterial instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageData.fromJson(e as Map<String, dynamic>))
          .toList(),
      article: json['article'] as String?,
      price: (json['price'] as num?)?.toInt(),
      productSizes: (json['product_sizes'] as List<dynamic>?)
          ?.map((e) => ProductSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      productColors: (json['product_colors'] as List<dynamic>?)
          ?.map((e) => ProductColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      productMaterial: (json['product_materials'] as List<dynamic>?)
          ?.map((e) => ProductMaterial.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'article': instance.article,
      'price': instance.price,
      'product_sizes': instance.productSizes,
      'product_colors': instance.productColors,
      'product_materials': instance.productMaterial,
    };
