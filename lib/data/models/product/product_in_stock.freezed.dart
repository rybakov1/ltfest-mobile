// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_in_stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductInStock {
  int get id;
  int get price;
  String? get sku;
  @JsonKey(name: 'quantity')
  int get stockQuantity; // Переименовали, чтобы не путать с количеством в корзине
  @JsonKey(name: 'product_color')
  ProductColor get productColor;
  @JsonKey(name: 'product_size')
  ProductSize get productSize;
  List<ImageData> get images;
  Product? get product;

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductInStockCopyWith<ProductInStock> get copyWith =>
      _$ProductInStockCopyWithImpl<ProductInStock>(
          this as ProductInStock, _$identity);

  /// Serializes this ProductInStock to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductInStock &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.productColor, productColor) ||
                other.productColor == productColor) &&
            (identical(other.productSize, productSize) ||
                other.productSize == productSize) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      price,
      sku,
      stockQuantity,
      productColor,
      productSize,
      const DeepCollectionEquality().hash(images),
      product);

  @override
  String toString() {
    return 'ProductInStock(id: $id, price: $price, sku: $sku, stockQuantity: $stockQuantity, productColor: $productColor, productSize: $productSize, images: $images, product: $product)';
  }
}

/// @nodoc
abstract mixin class $ProductInStockCopyWith<$Res> {
  factory $ProductInStockCopyWith(
          ProductInStock value, $Res Function(ProductInStock) _then) =
      _$ProductInStockCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int price,
      String? sku,
      @JsonKey(name: 'quantity') int stockQuantity,
      @JsonKey(name: 'product_color') ProductColor productColor,
      @JsonKey(name: 'product_size') ProductSize productSize,
      List<ImageData> images,
      Product? product});

  $ProductColorCopyWith<$Res> get productColor;
  $ProductSizeCopyWith<$Res> get productSize;
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$ProductInStockCopyWithImpl<$Res>
    implements $ProductInStockCopyWith<$Res> {
  _$ProductInStockCopyWithImpl(this._self, this._then);

  final ProductInStock _self;
  final $Res Function(ProductInStock) _then;

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? price = null,
    Object? sku = freezed,
    Object? stockQuantity = null,
    Object? productColor = null,
    Object? productSize = null,
    Object? images = null,
    Object? product = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      sku: freezed == sku
          ? _self.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      stockQuantity: null == stockQuantity
          ? _self.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      productColor: null == productColor
          ? _self.productColor
          : productColor // ignore: cast_nullable_to_non_nullable
              as ProductColor,
      productSize: null == productSize
          ? _self.productSize
          : productSize // ignore: cast_nullable_to_non_nullable
              as ProductSize,
      images: null == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageData>,
      product: freezed == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ));
  }

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductColorCopyWith<$Res> get productColor {
    return $ProductColorCopyWith<$Res>(_self.productColor, (value) {
      return _then(_self.copyWith(productColor: value));
    });
  }

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductSizeCopyWith<$Res> get productSize {
    return $ProductSizeCopyWith<$Res>(_self.productSize, (value) {
      return _then(_self.copyWith(productSize: value));
    });
  }

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_self.product!, (value) {
      return _then(_self.copyWith(product: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ProductInStock].
extension ProductInStockPatterns on ProductInStock {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ProductInStock value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductInStock() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ProductInStock value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductInStock():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ProductInStock value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductInStock() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            int price,
            String? sku,
            @JsonKey(name: 'quantity') int stockQuantity,
            @JsonKey(name: 'product_color') ProductColor productColor,
            @JsonKey(name: 'product_size') ProductSize productSize,
            List<ImageData> images,
            Product? product)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductInStock() when $default != null:
        return $default(_that.id, _that.price, _that.sku, _that.stockQuantity,
            _that.productColor, _that.productSize, _that.images, _that.product);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            int price,
            String? sku,
            @JsonKey(name: 'quantity') int stockQuantity,
            @JsonKey(name: 'product_color') ProductColor productColor,
            @JsonKey(name: 'product_size') ProductSize productSize,
            List<ImageData> images,
            Product? product)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductInStock():
        return $default(_that.id, _that.price, _that.sku, _that.stockQuantity,
            _that.productColor, _that.productSize, _that.images, _that.product);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            int price,
            String? sku,
            @JsonKey(name: 'quantity') int stockQuantity,
            @JsonKey(name: 'product_color') ProductColor productColor,
            @JsonKey(name: 'product_size') ProductSize productSize,
            List<ImageData> images,
            Product? product)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductInStock() when $default != null:
        return $default(_that.id, _that.price, _that.sku, _that.stockQuantity,
            _that.productColor, _that.productSize, _that.images, _that.product);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProductInStock implements ProductInStock {
  const _ProductInStock(
      {required this.id,
      required this.price,
      this.sku,
      @JsonKey(name: 'quantity') required this.stockQuantity,
      @JsonKey(name: 'product_color') required this.productColor,
      @JsonKey(name: 'product_size') required this.productSize,
      final List<ImageData> images = const [],
      this.product})
      : _images = images;
  factory _ProductInStock.fromJson(Map<String, dynamic> json) =>
      _$ProductInStockFromJson(json);

  @override
  final int id;
  @override
  final int price;
  @override
  final String? sku;
  @override
  @JsonKey(name: 'quantity')
  final int stockQuantity;
// Переименовали, чтобы не путать с количеством в корзине
  @override
  @JsonKey(name: 'product_color')
  final ProductColor productColor;
  @override
  @JsonKey(name: 'product_size')
  final ProductSize productSize;
  final List<ImageData> _images;
  @override
  @JsonKey()
  List<ImageData> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final Product? product;

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductInStockCopyWith<_ProductInStock> get copyWith =>
      __$ProductInStockCopyWithImpl<_ProductInStock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductInStockToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductInStock &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.productColor, productColor) ||
                other.productColor == productColor) &&
            (identical(other.productSize, productSize) ||
                other.productSize == productSize) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      price,
      sku,
      stockQuantity,
      productColor,
      productSize,
      const DeepCollectionEquality().hash(_images),
      product);

  @override
  String toString() {
    return 'ProductInStock(id: $id, price: $price, sku: $sku, stockQuantity: $stockQuantity, productColor: $productColor, productSize: $productSize, images: $images, product: $product)';
  }
}

/// @nodoc
abstract mixin class _$ProductInStockCopyWith<$Res>
    implements $ProductInStockCopyWith<$Res> {
  factory _$ProductInStockCopyWith(
          _ProductInStock value, $Res Function(_ProductInStock) _then) =
      __$ProductInStockCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int price,
      String? sku,
      @JsonKey(name: 'quantity') int stockQuantity,
      @JsonKey(name: 'product_color') ProductColor productColor,
      @JsonKey(name: 'product_size') ProductSize productSize,
      List<ImageData> images,
      Product? product});

  @override
  $ProductColorCopyWith<$Res> get productColor;
  @override
  $ProductSizeCopyWith<$Res> get productSize;
  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$ProductInStockCopyWithImpl<$Res>
    implements _$ProductInStockCopyWith<$Res> {
  __$ProductInStockCopyWithImpl(this._self, this._then);

  final _ProductInStock _self;
  final $Res Function(_ProductInStock) _then;

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? price = null,
    Object? sku = freezed,
    Object? stockQuantity = null,
    Object? productColor = null,
    Object? productSize = null,
    Object? images = null,
    Object? product = freezed,
  }) {
    return _then(_ProductInStock(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      sku: freezed == sku
          ? _self.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      stockQuantity: null == stockQuantity
          ? _self.stockQuantity
          : stockQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      productColor: null == productColor
          ? _self.productColor
          : productColor // ignore: cast_nullable_to_non_nullable
              as ProductColor,
      productSize: null == productSize
          ? _self.productSize
          : productSize // ignore: cast_nullable_to_non_nullable
              as ProductSize,
      images: null == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageData>,
      product: freezed == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ));
  }

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductColorCopyWith<$Res> get productColor {
    return $ProductColorCopyWith<$Res>(_self.productColor, (value) {
      return _then(_self.copyWith(productColor: value));
    });
  }

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductSizeCopyWith<$Res> get productSize {
    return $ProductSizeCopyWith<$Res>(_self.productSize, (value) {
      return _then(_self.copyWith(productSize: value));
    });
  }

  /// Create a copy of ProductInStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_self.product!, (value) {
      return _then(_self.copyWith(product: value));
    });
  }
}

// dart format on
