// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'age_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AgeCategory {
  int get id;
  String get title;

  /// Create a copy of AgeCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AgeCategoryCopyWith<AgeCategory> get copyWith =>
      _$AgeCategoryCopyWithImpl<AgeCategory>(this as AgeCategory, _$identity);

  /// Serializes this AgeCategory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AgeCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @override
  String toString() {
    return 'AgeCategory(id: $id, title: $title)';
  }
}

/// @nodoc
abstract mixin class $AgeCategoryCopyWith<$Res> {
  factory $AgeCategoryCopyWith(
          AgeCategory value, $Res Function(AgeCategory) _then) =
      _$AgeCategoryCopyWithImpl;
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class _$AgeCategoryCopyWithImpl<$Res> implements $AgeCategoryCopyWith<$Res> {
  _$AgeCategoryCopyWithImpl(this._self, this._then);

  final AgeCategory _self;
  final $Res Function(AgeCategory) _then;

  /// Create a copy of AgeCategory
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

/// Adds pattern-matching-related methods to [AgeCategory].
extension AgeCategoryPatterns on AgeCategory {
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
    TResult Function(_AgeCategory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AgeCategory() when $default != null:
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
    TResult Function(_AgeCategory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AgeCategory():
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
    TResult? Function(_AgeCategory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AgeCategory() when $default != null:
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
      case _AgeCategory() when $default != null:
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
      case _AgeCategory():
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
      case _AgeCategory() when $default != null:
        return $default(_that.id, _that.title);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AgeCategory implements AgeCategory {
  const _AgeCategory({required this.id, required this.title});
  factory _AgeCategory.fromJson(Map<String, dynamic> json) =>
      _$AgeCategoryFromJson(json);

  @override
  final int id;
  @override
  final String title;

  /// Create a copy of AgeCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AgeCategoryCopyWith<_AgeCategory> get copyWith =>
      __$AgeCategoryCopyWithImpl<_AgeCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AgeCategoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AgeCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @override
  String toString() {
    return 'AgeCategory(id: $id, title: $title)';
  }
}

/// @nodoc
abstract mixin class _$AgeCategoryCopyWith<$Res>
    implements $AgeCategoryCopyWith<$Res> {
  factory _$AgeCategoryCopyWith(
          _AgeCategory value, $Res Function(_AgeCategory) _then) =
      __$AgeCategoryCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class __$AgeCategoryCopyWithImpl<$Res> implements _$AgeCategoryCopyWith<$Res> {
  __$AgeCategoryCopyWithImpl(this._self, this._then);

  final _AgeCategory _self;
  final $Res Function(_AgeCategory) _then;

  /// Create a copy of AgeCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_AgeCategory(
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
