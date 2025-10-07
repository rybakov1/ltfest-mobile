// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductDetails {
  Product get product;
  @JsonKey(name: 'product_in_stocks')
  List<ProductInStock> get variations;

  /// Create a copy of ProductDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductDetailsCopyWith<ProductDetails> get copyWith =>
      _$ProductDetailsCopyWithImpl<ProductDetails>(
          this as ProductDetails, _$identity);

  /// Serializes this ProductDetails to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductDetails &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality()
                .equals(other.variations, variations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, product, const DeepCollectionEquality().hash(variations));

  @override
  String toString() {
    return 'ProductDetails(product: $product, variations: $variations)';
  }
}

/// @nodoc
abstract mixin class $ProductDetailsCopyWith<$Res> {
  factory $ProductDetailsCopyWith(
          ProductDetails value, $Res Function(ProductDetails) _then) =
      _$ProductDetailsCopyWithImpl;
  @useResult
  $Res call(
      {Product product,
      @JsonKey(name: 'product_in_stocks') List<ProductInStock> variations});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$ProductDetailsCopyWithImpl<$Res>
    implements $ProductDetailsCopyWith<$Res> {
  _$ProductDetailsCopyWithImpl(this._self, this._then);

  final ProductDetails _self;
  final $Res Function(ProductDetails) _then;

  /// Create a copy of ProductDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? variations = null,
  }) {
    return _then(_self.copyWith(
      product: null == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      variations: null == variations
          ? _self.variations
          : variations // ignore: cast_nullable_to_non_nullable
              as List<ProductInStock>,
    ));
  }

  /// Create a copy of ProductDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_self.product, (value) {
      return _then(_self.copyWith(product: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ProductDetails implements ProductDetails {
  const _ProductDetails(
      {required this.product,
      @JsonKey(name: 'product_in_stocks')
      required final List<ProductInStock> variations})
      : _variations = variations;
  factory _ProductDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsFromJson(json);

  @override
  final Product product;
  final List<ProductInStock> _variations;
  @override
  @JsonKey(name: 'product_in_stocks')
  List<ProductInStock> get variations {
    if (_variations is EqualUnmodifiableListView) return _variations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variations);
  }

  /// Create a copy of ProductDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductDetailsCopyWith<_ProductDetails> get copyWith =>
      __$ProductDetailsCopyWithImpl<_ProductDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductDetailsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductDetails &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality()
                .equals(other._variations, _variations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, product, const DeepCollectionEquality().hash(_variations));

  @override
  String toString() {
    return 'ProductDetails(product: $product, variations: $variations)';
  }
}

/// @nodoc
abstract mixin class _$ProductDetailsCopyWith<$Res>
    implements $ProductDetailsCopyWith<$Res> {
  factory _$ProductDetailsCopyWith(
          _ProductDetails value, $Res Function(_ProductDetails) _then) =
      __$ProductDetailsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Product product,
      @JsonKey(name: 'product_in_stocks') List<ProductInStock> variations});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$ProductDetailsCopyWithImpl<$Res>
    implements _$ProductDetailsCopyWith<$Res> {
  __$ProductDetailsCopyWithImpl(this._self, this._then);

  final _ProductDetails _self;
  final $Res Function(_ProductDetails) _then;

  /// Create a copy of ProductDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? product = null,
    Object? variations = null,
  }) {
    return _then(_ProductDetails(
      product: null == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      variations: null == variations
          ? _self._variations
          : variations // ignore: cast_nullable_to_non_nullable
              as List<ProductInStock>,
    ));
  }

  /// Create a copy of ProductDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_self.product, (value) {
      return _then(_self.copyWith(product: value));
    });
  }
}

// dart format on
