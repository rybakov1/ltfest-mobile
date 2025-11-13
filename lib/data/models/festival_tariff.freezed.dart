// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'festival_tariff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FestivalTariff {
  int get id;
  String get title;
  String? get description;
  double get price;
  double? get fact_price;
  String? get price_description;
  List<Feature> get feature;

  /// Create a copy of FestivalTariff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FestivalTariffCopyWith<FestivalTariff> get copyWith =>
      _$FestivalTariffCopyWithImpl<FestivalTariff>(
          this as FestivalTariff, _$identity);

  /// Serializes this FestivalTariff to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FestivalTariff &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fact_price, fact_price) ||
                other.fact_price == fact_price) &&
            (identical(other.price_description, price_description) ||
                other.price_description == price_description) &&
            const DeepCollectionEquality().equals(other.feature, feature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      price,
      fact_price,
      price_description,
      const DeepCollectionEquality().hash(feature));

  @override
  String toString() {
    return 'FestivalTariff(id: $id, title: $title, description: $description, price: $price, fact_price: $fact_price, price_description: $price_description, feature: $feature)';
  }
}

/// @nodoc
abstract mixin class $FestivalTariffCopyWith<$Res> {
  factory $FestivalTariffCopyWith(
          FestivalTariff value, $Res Function(FestivalTariff) _then) =
      _$FestivalTariffCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      double price,
      double? fact_price,
      String? price_description,
      List<Feature> feature});
}

/// @nodoc
class _$FestivalTariffCopyWithImpl<$Res>
    implements $FestivalTariffCopyWith<$Res> {
  _$FestivalTariffCopyWithImpl(this._self, this._then);

  final FestivalTariff _self;
  final $Res Function(FestivalTariff) _then;

  /// Create a copy of FestivalTariff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? price = null,
    Object? fact_price = freezed,
    Object? price_description = freezed,
    Object? feature = null,
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
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      fact_price: freezed == fact_price
          ? _self.fact_price
          : fact_price // ignore: cast_nullable_to_non_nullable
              as double?,
      price_description: freezed == price_description
          ? _self.price_description
          : price_description // ignore: cast_nullable_to_non_nullable
              as String?,
      feature: null == feature
          ? _self.feature
          : feature // ignore: cast_nullable_to_non_nullable
              as List<Feature>,
    ));
  }
}

/// Adds pattern-matching-related methods to [FestivalTariff].
extension FestivalTariffPatterns on FestivalTariff {
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
    TResult Function(_FestivalTariff value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FestivalTariff() when $default != null:
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
    TResult Function(_FestivalTariff value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FestivalTariff():
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
    TResult? Function(_FestivalTariff value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FestivalTariff() when $default != null:
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
            String title,
            String? description,
            double price,
            double? fact_price,
            String? price_description,
            List<Feature> feature)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FestivalTariff() when $default != null:
        return $default(_that.id, _that.title, _that.description, _that.price,
            _that.fact_price, _that.price_description, _that.feature);
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
            String title,
            String? description,
            double price,
            double? fact_price,
            String? price_description,
            List<Feature> feature)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FestivalTariff():
        return $default(_that.id, _that.title, _that.description, _that.price,
            _that.fact_price, _that.price_description, _that.feature);
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
            String title,
            String? description,
            double price,
            double? fact_price,
            String? price_description,
            List<Feature> feature)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FestivalTariff() when $default != null:
        return $default(_that.id, _that.title, _that.description, _that.price,
            _that.fact_price, _that.price_description, _that.feature);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FestivalTariff implements FestivalTariff {
  const _FestivalTariff(
      {required this.id,
      required this.title,
      this.description,
      required this.price,
      this.fact_price,
      this.price_description,
      required final List<Feature> feature})
      : _feature = feature;
  factory _FestivalTariff.fromJson(Map<String, dynamic> json) =>
      _$FestivalTariffFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final double price;
  @override
  final double? fact_price;
  @override
  final String? price_description;
  final List<Feature> _feature;
  @override
  List<Feature> get feature {
    if (_feature is EqualUnmodifiableListView) return _feature;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feature);
  }

  /// Create a copy of FestivalTariff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FestivalTariffCopyWith<_FestivalTariff> get copyWith =>
      __$FestivalTariffCopyWithImpl<_FestivalTariff>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FestivalTariffToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FestivalTariff &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fact_price, fact_price) ||
                other.fact_price == fact_price) &&
            (identical(other.price_description, price_description) ||
                other.price_description == price_description) &&
            const DeepCollectionEquality().equals(other._feature, _feature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      price,
      fact_price,
      price_description,
      const DeepCollectionEquality().hash(_feature));

  @override
  String toString() {
    return 'FestivalTariff(id: $id, title: $title, description: $description, price: $price, fact_price: $fact_price, price_description: $price_description, feature: $feature)';
  }
}

/// @nodoc
abstract mixin class _$FestivalTariffCopyWith<$Res>
    implements $FestivalTariffCopyWith<$Res> {
  factory _$FestivalTariffCopyWith(
          _FestivalTariff value, $Res Function(_FestivalTariff) _then) =
      __$FestivalTariffCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      double price,
      double? fact_price,
      String? price_description,
      List<Feature> feature});
}

/// @nodoc
class __$FestivalTariffCopyWithImpl<$Res>
    implements _$FestivalTariffCopyWith<$Res> {
  __$FestivalTariffCopyWithImpl(this._self, this._then);

  final _FestivalTariff _self;
  final $Res Function(_FestivalTariff) _then;

  /// Create a copy of FestivalTariff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? price = null,
    Object? fact_price = freezed,
    Object? price_description = freezed,
    Object? feature = null,
  }) {
    return _then(_FestivalTariff(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      fact_price: freezed == fact_price
          ? _self.fact_price
          : fact_price // ignore: cast_nullable_to_non_nullable
              as double?,
      price_description: freezed == price_description
          ? _self.price_description
          : price_description // ignore: cast_nullable_to_non_nullable
              as String?,
      feature: null == feature
          ? _self._feature
          : feature // ignore: cast_nullable_to_non_nullable
              as List<Feature>,
    ));
  }
}

// dart format on
