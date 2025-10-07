// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) =>
    _ProductDetails(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      variations: (json['product_in_stocks'] as List<dynamic>)
          .map((e) => ProductInStock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDetailsToJson(_ProductDetails instance) =>
    <String, dynamic>{
      'product': instance.product,
      'product_in_stocks': instance.variations,
    };
