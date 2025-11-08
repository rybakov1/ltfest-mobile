// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'priority_tariff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PriorityTariff {
  int get id;
  String get title;
  String get description;
  double get price;
  List<Feature> get features;

  /// Create a copy of PriorityTariff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PriorityTariffCopyWith<PriorityTariff> get copyWith =>
      _$PriorityTariffCopyWithImpl<PriorityTariff>(
          this as PriorityTariff, _$identity);

  /// Serializes this PriorityTariff to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PriorityTariff &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other.features, features));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, price,
      const DeepCollectionEquality().hash(features));

  @override
  String toString() {
    return 'PriorityTariff(id: $id, title: $title, description: $description, price: $price, features: $features)';
  }
}

/// @nodoc
abstract mixin class $PriorityTariffCopyWith<$Res> {
  factory $PriorityTariffCopyWith(
          PriorityTariff value, $Res Function(PriorityTariff) _then) =
      _$PriorityTariffCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      double price,
      List<Feature> features});
}

/// @nodoc
class _$PriorityTariffCopyWithImpl<$Res>
    implements $PriorityTariffCopyWith<$Res> {
  _$PriorityTariffCopyWithImpl(this._self, this._then);

  final PriorityTariff _self;
  final $Res Function(PriorityTariff) _then;

  /// Create a copy of PriorityTariff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? features = null,
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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      features: null == features
          ? _self.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<Feature>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PriorityTariff].
extension PriorityTariffPatterns on PriorityTariff {
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
    TResult Function(_PriorityTariff value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PriorityTariff() when $default != null:
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
    TResult Function(_PriorityTariff value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PriorityTariff():
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
    TResult? Function(_PriorityTariff value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PriorityTariff() when $default != null:
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
    TResult Function(int id, String title, String description, double price,
            List<Feature> features)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PriorityTariff() when $default != null:
        return $default(_that.id, _that.title, _that.description, _that.price,
            _that.features);
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
    TResult Function(int id, String title, String description, double price,
            List<Feature> features)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PriorityTariff():
        return $default(_that.id, _that.title, _that.description, _that.price,
            _that.features);
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
    TResult? Function(int id, String title, String description, double price,
            List<Feature> features)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PriorityTariff() when $default != null:
        return $default(_that.id, _that.title, _that.description, _that.price,
            _that.features);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PriorityTariff implements PriorityTariff {
  const _PriorityTariff(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required final List<Feature> features})
      : _features = features;
  factory _PriorityTariff.fromJson(Map<String, dynamic> json) =>
      _$PriorityTariffFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final double price;
  final List<Feature> _features;
  @override
  List<Feature> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  /// Create a copy of PriorityTariff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PriorityTariffCopyWith<_PriorityTariff> get copyWith =>
      __$PriorityTariffCopyWithImpl<_PriorityTariff>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PriorityTariffToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PriorityTariff &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, price,
      const DeepCollectionEquality().hash(_features));

  @override
  String toString() {
    return 'PriorityTariff(id: $id, title: $title, description: $description, price: $price, features: $features)';
  }
}

/// @nodoc
abstract mixin class _$PriorityTariffCopyWith<$Res>
    implements $PriorityTariffCopyWith<$Res> {
  factory _$PriorityTariffCopyWith(
          _PriorityTariff value, $Res Function(_PriorityTariff) _then) =
      __$PriorityTariffCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      double price,
      List<Feature> features});
}

/// @nodoc
class __$PriorityTariffCopyWithImpl<$Res>
    implements _$PriorityTariffCopyWith<$Res> {
  __$PriorityTariffCopyWithImpl(this._self, this._then);

  final _PriorityTariff _self;
  final $Res Function(_PriorityTariff) _then;

  /// Create a copy of PriorityTariff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? features = null,
  }) {
    return _then(_PriorityTariff(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      features: null == features
          ? _self._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<Feature>,
    ));
  }
}

// dart format on
