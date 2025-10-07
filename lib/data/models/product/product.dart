import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/product/product_attribute.dart';
import 'package:ltfest/data/models/product/product_in_stock.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required int id,
    required String name, // Важно: в JSON поле называется 'name', а не 'title'
    String? description,
    String? article,
    @JsonKey(name: 'product_materials', defaultValue: [])
    required List<ProductMaterial> productMaterials,
    @JsonKey(name: 'product_in_stocks', defaultValue: [])
    required List<ProductInStock> variations,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}