// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cart _$CartFromJson(Map<String, dynamic> json) => _Cart(
      id: (json['id'] as num).toInt(),
      items: (json['cart_items'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CartToJson(_Cart instance) => <String, dynamic>{
      'id': instance.id,
      'cart_items': instance.items,
    };
