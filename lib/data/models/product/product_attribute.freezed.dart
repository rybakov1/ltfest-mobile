// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_attribute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductMaterial {
  int get id;
  String get title;

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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @override
  String toString() {
    return 'ProductMaterial(id: $id, title: $title)';
  }
}

/// @nodoc
abstract mixin class $ProductMaterialCopyWith<$Res> {
  factory $ProductMaterialCopyWith(
          ProductMaterial value, $Res Function(ProductMaterial) _then) =
      _$ProductMaterialCopyWithImpl;
  @useResult
  $Res call({int id, String title});
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
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProductMaterial].
extension ProductMaterialPatterns on ProductMaterial {
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
    TResult Function(_ProductMaterial value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductMaterial() when $default != null:
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
    TResult Function(_ProductMaterial value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMaterial():
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
    TResult? Function(_ProductMaterial value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMaterial() when $default != null:
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
    TResult Function(int id, String title)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductMaterial() when $default != null:
        return $default(_that.id, _that.title);
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
    TResult Function(int id, String title) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMaterial():
        return $default(_that.id, _that.title);
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
    TResult? Function(int id, String title)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMaterial() when $default != null:
        return $default(_that.id, _that.title);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProductMaterial implements ProductMaterial {
  const _ProductMaterial({required this.id, required this.title});
  factory _ProductMaterial.fromJson(Map<String, dynamic> json) =>
      _$ProductMaterialFromJson(json);

  @override
  final int id;
  @override
  final String title;

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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @override
  String toString() {
    return 'ProductMaterial(id: $id, title: $title)';
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
  $Res call({int id, String title});
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
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_ProductMaterial(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ProductColor {
  int get id;
  String get title;
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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.hex, hex) || other.hex == hex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, hex);

  @override
  String toString() {
    return 'ProductColor(id: $id, title: $title, hex: $hex)';
  }
}

/// @nodoc
abstract mixin class $ProductColorCopyWith<$Res> {
  factory $ProductColorCopyWith(
          ProductColor value, $Res Function(ProductColor) _then) =
      _$ProductColorCopyWithImpl;
  @useResult
  $Res call({int id, String title, String? hex});
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
    Object? id = null,
    Object? title = null,
    Object? hex = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hex: freezed == hex
          ? _self.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProductColor].
extension ProductColorPatterns on ProductColor {
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
    TResult Function(_ProductColor value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductColor() when $default != null:
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
    TResult Function(_ProductColor value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductColor():
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
    TResult? Function(_ProductColor value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductColor() when $default != null:
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
    TResult Function(int id, String title, String? hex)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductColor() when $default != null:
        return $default(_that.id, _that.title, _that.hex);
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
    TResult Function(int id, String title, String? hex) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductColor():
        return $default(_that.id, _that.title, _that.hex);
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
    TResult? Function(int id, String title, String? hex)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductColor() when $default != null:
        return $default(_that.id, _that.title, _that.hex);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProductColor implements ProductColor {
  const _ProductColor({required this.id, required this.title, this.hex});
  factory _ProductColor.fromJson(Map<String, dynamic> json) =>
      _$ProductColorFromJson(json);

  @override
  final int id;
  @override
  final String title;
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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.hex, hex) || other.hex == hex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, hex);

  @override
  String toString() {
    return 'ProductColor(id: $id, title: $title, hex: $hex)';
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
  $Res call({int id, String title, String? hex});
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
    Object? id = null,
    Object? title = null,
    Object? hex = freezed,
  }) {
    return _then(_ProductColor(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hex: freezed == hex
          ? _self.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ProductSize {
  int get id;
  String get title;

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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @override
  String toString() {
    return 'ProductSize(id: $id, title: $title)';
  }
}

/// @nodoc
abstract mixin class $ProductSizeCopyWith<$Res> {
  factory $ProductSizeCopyWith(
          ProductSize value, $Res Function(ProductSize) _then) =
      _$ProductSizeCopyWithImpl;
  @useResult
  $Res call({int id, String title});
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
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProductSize].
extension ProductSizePatterns on ProductSize {
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
    TResult Function(_ProductSize value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductSize() when $default != null:
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
    TResult Function(_ProductSize value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductSize():
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
    TResult? Function(_ProductSize value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductSize() when $default != null:
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
    TResult Function(int id, String title)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductSize() when $default != null:
        return $default(_that.id, _that.title);
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
    TResult Function(int id, String title) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductSize():
        return $default(_that.id, _that.title);
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
    TResult? Function(int id, String title)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductSize() when $default != null:
        return $default(_that.id, _that.title);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProductSize implements ProductSize {
  const _ProductSize({required this.id, required this.title});
  factory _ProductSize.fromJson(Map<String, dynamic> json) =>
      _$ProductSizeFromJson(json);

  @override
  final int id;
  @override
  final String title;

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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @override
  String toString() {
    return 'ProductSize(id: $id, title: $title)';
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
  $Res call({int id, String title});
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
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_ProductSize(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
