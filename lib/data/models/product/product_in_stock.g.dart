// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_in_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductInStock _$ProductInStockFromJson(Map<String, dynamic> json) =>
    _ProductInStock(
      documentId: json['documentId'] as String?,
      id: (json['id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      sku: json['sku'] as String?,
      stockQuantity: (json['quantity'] as num).toInt(),
      productColor:
          ProductColor.fromJson(json['product_color'] as Map<String, dynamic>),
      productSize:
          ProductSize.fromJson(json['product_size'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ImageData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductInStockToJson(_ProductInStock instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'id': instance.id,
      'price': instance.price,
      'sku': instance.sku,
      'quantity': instance.stockQuantity,
      'product_color': instance.productColor,
      'product_size': instance.productSize,
      'images': instance.images,
      'product': instance.product,
    };
