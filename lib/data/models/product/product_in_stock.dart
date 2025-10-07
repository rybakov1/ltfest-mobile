import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/product/product.dart';
import 'package:ltfest/data/models/product/product_attribute.dart';
import '../image_data.dart';

part 'product_in_stock.freezed.dart';
part 'product_in_stock.g.dart';

@freezed
abstract class ProductInStock with _$ProductInStock {
  const factory ProductInStock({
    required int id,
    required int price,
    String? sku,
    @JsonKey(name: 'quantity') required int stockQuantity, // Переименовали, чтобы не путать с количеством в корзине
    @JsonKey(name: 'product_color') required ProductColor productColor,
    @JsonKey(name: 'product_size') required ProductSize productSize,
    @Default([]) List<ImageData> images,
    Product? product,
  }) = _ProductInStock;

  factory ProductInStock.fromJson(Map<String, dynamic> json) => _$ProductInStockFromJson(json);
}