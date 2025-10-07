import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_attribute.freezed.dart';
part 'product_attribute.g.dart';

@freezed
abstract class ProductMaterial with _$ProductMaterial {
  const factory ProductMaterial({
    required int id,
    required String title,
  }) = _ProductMaterial;

  factory ProductMaterial.fromJson(Map<String, dynamic> json) => _$ProductMaterialFromJson(json);
}

@freezed
abstract class ProductColor with _$ProductColor {
  const factory ProductColor({
    required int id,
    required String title,
    String? hex,
  }) = _ProductColor;

  factory ProductColor.fromJson(Map<String, dynamic> json) => _$ProductColorFromJson(json);
}

@freezed
abstract class ProductSize with _$ProductSize {
  const factory ProductSize({
    required int id,
    required String title,
  }) = _ProductSize;

  factory ProductSize.fromJson(Map<String, dynamic> json) => _$ProductSizeFromJson(json);
}