import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_data.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class ProductSize with _$ProductSize {
  const factory ProductSize({
    String? title,
  }) = _ProductSize;

  factory ProductSize.fromJson(Map<String, dynamic> json) =>
      _$ProductSizeFromJson(json);
}

@freezed
abstract class ProductColor with _$ProductColor {
  const factory ProductColor({
    String? title,
    String? hex,
  }) = _ProductColor;

  factory ProductColor.fromJson(Map<String, dynamic> json) =>
      _$ProductColorFromJson(json);
}

@freezed
abstract class ProductMaterial with _$ProductMaterial {
  const factory ProductMaterial({
    String? title,
  }) = _ProductMaterial;

  factory ProductMaterial.fromJson(Map<String, dynamic> json) =>
      _$ProductMaterialFromJson(json);
}

@freezed
abstract class Product with _$Product {
  const factory Product({
    required int id,
    String? title,
    String? description,
    List<ImageData>? images,
    String? article,
    int? price,
    @JsonKey(name: "product_sizes") List<ProductSize>? productSizes,
    @JsonKey(name: "product_colors") List<ProductColor>? productColors,
    @JsonKey(name: "product_materials") List<ProductMaterial>? productMaterial,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}