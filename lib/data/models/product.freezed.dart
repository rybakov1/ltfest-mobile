// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductSize {
  String? get title;

  /// Create a copy of ProductSize
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductSizeCopyWith<ProductSize> get copyWith =>
      _$ProductSizeCopyWithImpl<ProductSize>(this as ProductSize, _$identity);

  /// Serializes this ProductSize to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductSize &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @override
  String toString() {
    return 'ProductSize(title: $title)';
  }
}

/// @nodoc
abstract mixin class $ProductSizeCopyWith<$Res> {
  factory $ProductSizeCopyWith(
          ProductSize value, $Res Function(ProductSize) _then) =
      _$ProductSizeCopyWithImpl;
  @useResult
  $Res call({String? title});
}

/// @nodoc
class _$ProductSizeCopyWithImpl<$Res> implements $ProductSizeCopyWith<$Res> {
  _$ProductSizeCopyWithImpl(this._self, this._then);

  final ProductSize _self;
  final $Res Function(ProductSize) _then;

  /// Create a copy of ProductSize
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_self.copyWith(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ProductSize implements ProductSize {
  const _ProductSize({this.title});
  factory _ProductSize.fromJson(Map<String, dynamic> json) =>
      _$ProductSizeFromJson(json);

  @override
  final String? title;

  /// Create a copy of ProductSize
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductSizeCopyWith<_ProductSize> get copyWith =>
      __$ProductSizeCopyWithImpl<_ProductSize>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductSizeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductSize &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @override
  String toString() {
    return 'ProductSize(title: $title)';
  }
}

/// @nodoc
abstract mixin class _$ProductSizeCopyWith<$Res>
    implements $ProductSizeCopyWith<$Res> {
  factory _$ProductSizeCopyWith(
          _ProductSize value, $Res Function(_ProductSize) _then) =
      __$ProductSizeCopyWithImpl;
  @override
  @useResult
  $Res call({String? title});
}

/// @nodoc
class __$ProductSizeCopyWithImpl<$Res> implements _$ProductSizeCopyWith<$Res> {
  __$ProductSizeCopyWithImpl(this._self, this._then);

  final _ProductSize _self;
  final $Res Function(_ProductSize) _then;

  /// Create a copy of ProductSize
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_ProductSize(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ProductColor {
  String? get title;
  String? get hex;

  /// Create a copy of ProductColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductColorCopyWith<ProductColor> get copyWith =>
      _$ProductColorCopyWithImpl<ProductColor>(
          this as ProductColor, _$identity);

  /// Serializes this ProductColor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductColor &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.hex, hex) || other.hex == hex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, hex);

  @override
  String toString() {
    return 'ProductColor(title: $title, hex: $hex)';
  }
}

/// @nodoc
abstract mixin class $ProductColorCopyWith<$Res> {
  factory $ProductColorCopyWith(
          ProductColor value, $Res Function(ProductColor) _then) =
      _$ProductColorCopyWithImpl;
  @useResult
  $Res call({String? title, String? hex});
}

/// @nodoc
class _$ProductColorCopyWithImpl<$Res> implements $ProductColorCopyWith<$Res> {
  _$ProductColorCopyWithImpl(this._self, this._then);

  final ProductColor _self;
  final $Res Function(ProductColor) _then;

  /// Create a copy of ProductColor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? hex = freezed,
  }) {
    return _then(_self.copyWith(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      hex: freezed == hex
          ? _self.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ProductColor implements ProductColor {
  const _ProductColor({this.title, this.hex});
  factory _ProductColor.fromJson(Map<String, dynamic> json) =>
      _$ProductColorFromJson(json);

  @override
  final String? title;
  @override
  final String? hex;

  /// Create a copy of ProductColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductColorCopyWith<_ProductColor> get copyWith =>
      __$ProductColorCopyWithImpl<_ProductColor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductColorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductColor &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.hex, hex) || other.hex == hex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, hex);

  @override
  String toString() {
    return 'ProductColor(title: $title, hex: $hex)';
  }
}

/// @nodoc
abstract mixin class _$ProductColorCopyWith<$Res>
    implements $ProductColorCopyWith<$Res> {
  factory _$ProductColorCopyWith(
          _ProductColor value, $Res Function(_ProductColor) _then) =
      __$ProductColorCopyWithImpl;
  @override
  @useResult
  $Res call({String? title, String? hex});
}

/// @nodoc
class __$ProductColorCopyWithImpl<$Res>
    implements _$ProductColorCopyWith<$Res> {
  __$ProductColorCopyWithImpl(this._self, this._then);

  final _ProductColor _self;
  final $Res Function(_ProductColor) _then;

  /// Create a copy of ProductColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? hex = freezed,
  }) {
    return _then(_ProductColor(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      hex: freezed == hex
          ? _self.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ProductMaterial {
  String? get title;

  /// Create a copy of ProductMaterial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductMaterialCopyWith<ProductMaterial> get copyWith =>
      _$ProductMaterialCopyWithImpl<ProductMaterial>(
          this as ProductMaterial, _$identity);

  /// Serializes this ProductMaterial to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductMaterial &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @override
  String toString() {
    return 'ProductMaterial(title: $title)';
  }
}

/// @nodoc
abstract mixin class $ProductMaterialCopyWith<$Res> {
  factory $ProductMaterialCopyWith(
          ProductMaterial value, $Res Function(ProductMaterial) _then) =
      _$ProductMaterialCopyWithImpl;
  @useResult
  $Res call({String? title});
}

/// @nodoc
class _$ProductMaterialCopyWithImpl<$Res>
    implements $ProductMaterialCopyWith<$Res> {
  _$ProductMaterialCopyWithImpl(this._self, this._then);

  final ProductMaterial _self;
  final $Res Function(ProductMaterial) _then;

  /// Create a copy of ProductMaterial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_self.copyWith(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ProductMaterial implements ProductMaterial {
  const _ProductMaterial({this.title});
  factory _ProductMaterial.fromJson(Map<String, dynamic> json) =>
      _$ProductMaterialFromJson(json);

  @override
  final String? title;

  /// Create a copy of ProductMaterial
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductMaterialCopyWith<_ProductMaterial> get copyWith =>
      __$ProductMaterialCopyWithImpl<_ProductMaterial>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductMaterialToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductMaterial &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @override
  String toString() {
    return 'ProductMaterial(title: $title)';
  }
}

/// @nodoc
abstract mixin class _$ProductMaterialCopyWith<$Res>
    implements $ProductMaterialCopyWith<$Res> {
  factory _$ProductMaterialCopyWith(
          _ProductMaterial value, $Res Function(_ProductMaterial) _then) =
      __$ProductMaterialCopyWithImpl;
  @override
  @useResult
  $Res call({String? title});
}

/// @nodoc
class __$ProductMaterialCopyWithImpl<$Res>
    implements _$ProductMaterialCopyWith<$Res> {
  __$ProductMaterialCopyWithImpl(this._self, this._then);

  final _ProductMaterial _self;
  final $Res Function(_ProductMaterial) _then;

  /// Create a copy of ProductMaterial
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_ProductMaterial(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Product {
  int get id;
  String? get title;
  String? get description;
  List<ImageData>? get images;
  String? get article;
  int? get price;
  @JsonKey(name: "product_sizes")
  List<ProductSize>? get productSizes;
  @JsonKey(name: "product_colors")
  List<ProductColor>? get productColors;
  @JsonKey(name: "product_materials")
  List<ProductMaterial>? get productMaterial;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductCopyWith<Product> get copyWith =>
      _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Product &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            (identical(other.article, article) || other.article == article) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality()
                .equals(other.productSizes, productSizes) &&
            const DeepCollectionEquality()
                .equals(other.productColors, productColors) &&
            const DeepCollectionEquality()
                .equals(other.productMaterial, productMaterial));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(images),
      article,
      price,
      const DeepCollectionEquality().hash(productSizes),
      const DeepCollectionEquality().hash(productColors),
      const DeepCollectionEquality().hash(productMaterial));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, images: $images, article: $article, price: $price, productSizes: $productSizes, productColors: $productColors, productMaterial: $productMaterial)';
  }
}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) =
      _$ProductCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String? title,
      String? description,
      List<ImageData>? images,
      String? article,
      int? price,
      @JsonKey(name: "product_sizes") List<ProductSize>? productSizes,
      @JsonKey(name: "product_colors") List<ProductColor>? productColors,
      @JsonKey(name: "product_materials")
      List<ProductMaterial>? productMaterial});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? images = freezed,
    Object? article = freezed,
    Object? price = freezed,
    Object? productSizes = freezed,
    Object? productColors = freezed,
    Object? productMaterial = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageData>?,
      article: freezed == article
          ? _self.article
          : article // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      productSizes: freezed == productSizes
          ? _self.productSizes
          : productSizes // ignore: cast_nullable_to_non_nullable
              as List<ProductSize>?,
      productColors: freezed == productColors
          ? _self.productColors
          : productColors // ignore: cast_nullable_to_non_nullable
              as List<ProductColor>?,
      productMaterial: freezed == productMaterial
          ? _self.productMaterial
          : productMaterial // ignore: cast_nullable_to_non_nullable
              as List<ProductMaterial>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Product implements Product {
  const _Product(
      {required this.id,
      this.title,
      this.description,
      final List<ImageData>? images,
      this.article,
      this.price,
      @JsonKey(name: "product_sizes") final List<ProductSize>? productSizes,
      @JsonKey(name: "product_colors") final List<ProductColor>? productColors,
      @JsonKey(name: "product_materials")
      final List<ProductMaterial>? productMaterial})
      : _images = images,
        _productSizes = productSizes,
        _productColors = productColors,
        _productMaterial = productMaterial;
  factory _Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final String? description;
  final List<ImageData>? _images;
  @override
  List<ImageData>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? article;
  @override
  final int? price;
  final List<ProductSize>? _productSizes;
  @override
  @JsonKey(name: "product_sizes")
  List<ProductSize>? get productSizes {
    final value = _productSizes;
    if (value == null) return null;
    if (_productSizes is EqualUnmodifiableListView) return _productSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductColor>? _productColors;
  @override
  @JsonKey(name: "product_colors")
  List<ProductColor>? get productColors {
    final value = _productColors;
    if (value == null) return null;
    if (_productColors is EqualUnmodifiableListView) return _productColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductMaterial>? _productMaterial;
  @override
  @JsonKey(name: "product_materials")
  List<ProductMaterial>? get productMaterial {
    final value = _productMaterial;
    if (value == null) return null;
    if (_productMaterial is EqualUnmodifiableListView) return _productMaterial;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductCopyWith<_Product> get copyWith =>
      __$ProductCopyWithImpl<_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Product &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.article, article) || other.article == article) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality()
                .equals(other._productSizes, _productSizes) &&
            const DeepCollectionEquality()
                .equals(other._productColors, _productColors) &&
            const DeepCollectionEquality()
                .equals(other._productMaterial, _productMaterial));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_images),
      article,
      price,
      const DeepCollectionEquality().hash(_productSizes),
      const DeepCollectionEquality().hash(_productColors),
      const DeepCollectionEquality().hash(_productMaterial));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, images: $images, article: $article, price: $price, productSizes: $productSizes, productColors: $productColors, productMaterial: $productMaterial)';
  }
}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) =
      __$ProductCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String? title,
      String? description,
      List<ImageData>? images,
      String? article,
      int? price,
      @JsonKey(name: "product_sizes") List<ProductSize>? productSizes,
      @JsonKey(name: "product_colors") List<ProductColor>? productColors,
      @JsonKey(name: "product_materials")
      List<ProductMaterial>? productMaterial});
}

/// @nodoc
class __$ProductCopyWithImpl<$Res> implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? images = freezed,
    Object? article = freezed,
    Object? price = freezed,
    Object? productSizes = freezed,
    Object? productColors = freezed,
    Object? productMaterial = freezed,
  }) {
    return _then(_Product(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ImageData>?,
      article: freezed == article
          ? _self.article
          : article // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      productSizes: freezed == productSizes
          ? _self._productSizes
          : productSizes // ignore: cast_nullable_to_non_nullable
              as List<ProductSize>?,
      productColors: freezed == productColors
          ? _self._productColors
          : productColors // ignore: cast_nullable_to_non_nullable
              as List<ProductColor>?,
      productMaterial: freezed == productMaterial
          ? _self._productMaterial
          : productMaterial // ignore: cast_nullable_to_non_nullable
              as List<ProductMaterial>?,
    ));
  }
}

// dart format on
