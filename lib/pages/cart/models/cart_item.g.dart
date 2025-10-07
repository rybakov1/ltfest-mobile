// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
      id: (json['id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      productInStock: json['product_in_stock'] == null
          ? null
          : ProductInStock.fromJson(
              json['product_in_stock'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'product_in_stock': instance.productInStock,
    };
