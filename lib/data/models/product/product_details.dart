import 'package:freezed_annotation/freezed_annotation.dart';
import 'product.dart';
import 'product_in_stock.dart';

part 'product_details.freezed.dart';
part 'product_details.g.dart';

@freezed
abstract class ProductDetails with _$ProductDetails {
  const factory ProductDetails({
    required Product product,
    @JsonKey(name: 'product_in_stocks')
    required List<ProductInStock> variations,
  }) = _ProductDetails;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => _$ProductDetailsFromJson(json);
}