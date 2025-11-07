import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/data/models/product/product_in_stock.dart';
import 'package:ltfest/data/models/user.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
abstract class Order with _$Order {
  const factory Order({
    int? id,
    required String name,
    required String email,
    required String phone,
    required int amount,
    required String type,
    required Map<String, dynamic>? details,
    String? paymentId,
    String? paymentStatus,
    // User? user,
    Festival? festival,
    Laboratory? laboratory,
    @JsonKey(name: 'product_in_stock') ProductInStock? productInStock,
    DateTime? createdAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
