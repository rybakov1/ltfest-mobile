// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {
  int get id;
  String get name; // Важно: в JSON поле называется 'name', а не 'title'
  String? get description;
  String? get article;
  @JsonKey(name: 'product_materials', defaultValue: [])
  List<ProductMaterial> get productMaterials;
  @JsonKey(name: 'product_in_stocks', defaultValue: [])
  List<ProductInStock> get variations;

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
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.article, article) || other.article == article) &&
            const DeepCollectionEquality()
                .equals(other.productMaterials, productMaterials) &&
            const DeepCollectionEquality()
                .equals(other.variations, variations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      article,
      const DeepCollectionEquality().hash(productMaterials),
      const DeepCollectionEquality().hash(variations));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, article: $article, productMaterials: $productMaterials, variations: $variations)';
  }
}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) =
      _$ProductCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      String? article,
      @JsonKey(name: 'product_materials', defaultValue: [])
      List<ProductMaterial> productMaterials,
      @JsonKey(name: 'product_in_stocks', defaultValue: [])
      List<ProductInStock> variations});
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
    Object? name = null,
    Object? description = freezed,
    Object? article = freezed,
    Object? productMaterials = null,
    Object? variations = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      article: freezed == article
          ? _self.article
          : article // ignore: cast_nullable_to_non_nullable
              as String?,
      productMaterials: null == productMaterials
          ? _self.productMaterials
          : productMaterials // ignore: cast_nullable_to_non_nullable
              as List<ProductMaterial>,
      variations: null == variations
          ? _self.variations
          : variations // ignore: cast_nullable_to_non_nullable
              as List<ProductInStock>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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
    TResult Function(_Product value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Product() when $default != null:
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
    TResult Function(_Product value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Product():
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
    TResult? Function(_Product value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Product() when $default != null:
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
            String name,
            String? description,
            String? article,
            @JsonKey(name: 'product_materials', defaultValue: [])
            List<ProductMaterial> productMaterials,
            @JsonKey(name: 'product_in_stocks', defaultValue: [])
            List<ProductInStock> variations)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Product() when $default != null:
        return $default(_that.id, _that.name, _that.description, _that.article,
            _that.productMaterials, _that.variations);
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
            String name,
            String? description,
            String? article,
            @JsonKey(name: 'product_materials', defaultValue: [])
            List<ProductMaterial> productMaterials,
            @JsonKey(name: 'product_in_stocks', defaultValue: [])
            List<ProductInStock> variations)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Product():
        return $default(_that.id, _that.name, _that.description, _that.article,
            _that.productMaterials, _that.variations);
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
            String name,
            String? description,
            String? article,
            @JsonKey(name: 'product_materials', defaultValue: [])
            List<ProductMaterial> productMaterials,
            @JsonKey(name: 'product_in_stocks', defaultValue: [])
            List<ProductInStock> variations)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Product() when $default != null:
        return $default(_that.id, _that.name, _that.description, _that.article,
            _that.productMaterials, _that.variations);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Product implements Product {
  const _Product(
      {required this.id,
      required this.name,
      this.description,
      this.article,
      @JsonKey(name: 'product_materials', defaultValue: [])
      required final List<ProductMaterial> productMaterials,
      @JsonKey(name: 'product_in_stocks', defaultValue: [])
      required final List<ProductInStock> variations})
      : _productMaterials = productMaterials,
        _variations = variations;
  factory _Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  @override
  final int id;
  @override
  final String name;
// Важно: в JSON поле называется 'name', а не 'title'
  @override
  final String? description;
  @override
  final String? article;
  final List<ProductMaterial> _productMaterials;
  @override
  @JsonKey(name: 'product_materials', defaultValue: [])
  List<ProductMaterial> get productMaterials {
    if (_productMaterials is EqualUnmodifiableListView)
      return _productMaterials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productMaterials);
  }

  final List<ProductInStock> _variations;
  @override
  @JsonKey(name: 'product_in_stocks', defaultValue: [])
  List<ProductInStock> get variations {
    if (_variations is EqualUnmodifiableListView) return _variations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variations);
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
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.article, article) || other.article == article) &&
            const DeepCollectionEquality()
                .equals(other._productMaterials, _productMaterials) &&
            const DeepCollectionEquality()
                .equals(other._variations, _variations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      article,
      const DeepCollectionEquality().hash(_productMaterials),
      const DeepCollectionEquality().hash(_variations));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, article: $article, productMaterials: $productMaterials, variations: $variations)';
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
      String name,
      String? description,
      String? article,
      @JsonKey(name: 'product_materials', defaultValue: [])
      List<ProductMaterial> productMaterials,
      @JsonKey(name: 'product_in_stocks', defaultValue: [])
      List<ProductInStock> variations});
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
    Object? name = null,
    Object? description = freezed,
    Object? article = freezed,
    Object? productMaterials = null,
    Object? variations = null,
  }) {
    return _then(_Product(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      article: freezed == article
          ? _self.article
          : article // ignore: cast_nullable_to_non_nullable
              as String?,
      productMaterials: null == productMaterials
          ? _self._productMaterials
          : productMaterials // ignore: cast_nullable_to_non_nullable
              as List<ProductMaterial>,
      variations: null == variations
          ? _self._variations
          : variations // ignore: cast_nullable_to_non_nullable
              as List<ProductInStock>,
    ));
  }
}

// dart format on
