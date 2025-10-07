// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      article: json['article'] as String?,
      productMaterials: (json['product_materials'] as List<dynamic>?)
              ?.map((e) => ProductMaterial.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      variations: (json['product_in_stocks'] as List<dynamic>?)
              ?.map((e) => ProductInStock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'article': instance.article,
      'product_materials': instance.productMaterials,
      'product_in_stocks': instance.variations,
    };
