// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      amount: (json['amount'] as num).toInt(),
      type: json['type'] as String,
      details: json['details'] as Map<String, dynamic>?,
      paymentId: json['paymentId'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      festival: json['festival'] == null
          ? null
          : Festival.fromJson(json['festival'] as Map<String, dynamic>),
      laboratory: json['laboratory'] == null
          ? null
          : Laboratory.fromJson(json['laboratory'] as Map<String, dynamic>),
      productInStock: json['product_in_stock'] == null
          ? null
          : ProductInStock.fromJson(
              json['product_in_stock'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'amount': instance.amount,
      'type': instance.type,
      'details': instance.details,
      'paymentId': instance.paymentId,
      'paymentStatus': instance.paymentStatus,
      'festival': instance.festival,
      'laboratory': instance.laboratory,
      'product_in_stock': instance.productInStock,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
