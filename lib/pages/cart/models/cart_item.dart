import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/product/product_in_stock.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItem with _$CartItem {
  const factory CartItem({
    required int id,
    required int quantity, // Количество в корзине
    @JsonKey(name: 'product_in_stock') ProductInStock? productInStock,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
}