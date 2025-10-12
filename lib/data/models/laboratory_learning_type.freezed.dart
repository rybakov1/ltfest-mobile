// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laboratory_learning_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LearningType {
  @JsonKey(name: 'id')
  int get id;
  @JsonKey(name: 'type')
  String get type;
  @JsonKey(name: 'price')
  int get price;
  @JsonKey(name: 'date_info')
  String? get dateInfo;
  @JsonKey(name: 'location')
  String? get location;
  @JsonKey(name: 'duration')
  String? get duration;
  @JsonKey(name: 'certificate')
  String? get certificate;

  /// Create a copy of LearningType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LearningTypeCopyWith<LearningType> get copyWith =>
      _$LearningTypeCopyWithImpl<LearningType>(
          this as LearningType, _$identity);

  /// Serializes this LearningType to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LearningType &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.dateInfo, dateInfo) ||
                other.dateInfo == dateInfo) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.certificate, certificate) ||
                other.certificate == certificate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, price, dateInfo, location, duration, certificate);

  @override
  String toString() {
    return 'LearningType(id: $id, type: $type, price: $price, dateInfo: $dateInfo, location: $location, duration: $duration, certificate: $certificate)';
  }
}

/// @nodoc
abstract mixin class $LearningTypeCopyWith<$Res> {
  factory $LearningTypeCopyWith(
          LearningType value, $Res Function(LearningType) _then) =
      _$LearningTypeCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'type') String type,
      @JsonKey(name: 'price') int price,
      @JsonKey(name: 'date_info') String? dateInfo,
      @JsonKey(name: 'location') String? location,
      @JsonKey(name: 'duration') String? duration,
      @JsonKey(name: 'certificate') String? certificate});
}

/// @nodoc
class _$LearningTypeCopyWithImpl<$Res> implements $LearningTypeCopyWith<$Res> {
  _$LearningTypeCopyWithImpl(this._self, this._then);

  final LearningType _self;
  final $Res Function(LearningType) _then;

  /// Create a copy of LearningType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? price = null,
    Object? dateInfo = freezed,
    Object? location = freezed,
    Object? duration = freezed,
    Object? certificate = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      dateInfo: freezed == dateInfo
          ? _self.dateInfo
          : dateInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      certificate: freezed == certificate
          ? _self.certificate
          : certificate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LearningType].
extension LearningTypePatterns on LearningType {
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
    TResult Function(_LearningType value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LearningType() when $default != null:
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
    TResult Function(_LearningType value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LearningType():
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
    TResult? Function(_LearningType value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LearningType() when $default != null:
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
            @JsonKey(name: 'id') int id,
            @JsonKey(name: 'type') String type,
            @JsonKey(name: 'price') int price,
            @JsonKey(name: 'date_info') String? dateInfo,
            @JsonKey(name: 'location') String? location,
            @JsonKey(name: 'duration') String? duration,
            @JsonKey(name: 'certificate') String? certificate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LearningType() when $default != null:
        return $default(_that.id, _that.type, _that.price, _that.dateInfo,
            _that.location, _that.duration, _that.certificate);
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
            @JsonKey(name: 'id') int id,
            @JsonKey(name: 'type') String type,
            @JsonKey(name: 'price') int price,
            @JsonKey(name: 'date_info') String? dateInfo,
            @JsonKey(name: 'location') String? location,
            @JsonKey(name: 'duration') String? duration,
            @JsonKey(name: 'certificate') String? certificate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LearningType():
        return $default(_that.id, _that.type, _that.price, _that.dateInfo,
            _that.location, _that.duration, _that.certificate);
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
            @JsonKey(name: 'id') int id,
            @JsonKey(name: 'type') String type,
            @JsonKey(name: 'price') int price,
            @JsonKey(name: 'date_info') String? dateInfo,
            @JsonKey(name: 'location') String? location,
            @JsonKey(name: 'duration') String? duration,
            @JsonKey(name: 'certificate') String? certificate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LearningType() when $default != null:
        return $default(_that.id, _that.type, _that.price, _that.dateInfo,
            _that.location, _that.duration, _that.certificate);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LearningType implements LearningType {
  const _LearningType(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'type') required this.type,
      @JsonKey(name: 'price') required this.price,
      @JsonKey(name: 'date_info') this.dateInfo,
      @JsonKey(name: 'location') this.location,
      @JsonKey(name: 'duration') this.duration,
      @JsonKey(name: 'certificate') this.certificate});
  factory _LearningType.fromJson(Map<String, dynamic> json) =>
      _$LearningTypeFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'type')
  final String type;
  @override
  @JsonKey(name: 'price')
  final int price;
  @override
  @JsonKey(name: 'date_info')
  final String? dateInfo;
  @override
  @JsonKey(name: 'location')
  final String? location;
  @override
  @JsonKey(name: 'duration')
  final String? duration;
  @override
  @JsonKey(name: 'certificate')
  final String? certificate;

  /// Create a copy of LearningType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LearningTypeCopyWith<_LearningType> get copyWith =>
      __$LearningTypeCopyWithImpl<_LearningType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LearningTypeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LearningType &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.dateInfo, dateInfo) ||
                other.dateInfo == dateInfo) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.certificate, certificate) ||
                other.certificate == certificate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, price, dateInfo, location, duration, certificate);

  @override
  String toString() {
    return 'LearningType(id: $id, type: $type, price: $price, dateInfo: $dateInfo, location: $location, duration: $duration, certificate: $certificate)';
  }
}

/// @nodoc
abstract mixin class _$LearningTypeCopyWith<$Res>
    implements $LearningTypeCopyWith<$Res> {
  factory _$LearningTypeCopyWith(
          _LearningType value, $Res Function(_LearningType) _then) =
      __$LearningTypeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'type') String type,
      @JsonKey(name: 'price') int price,
      @JsonKey(name: 'date_info') String? dateInfo,
      @JsonKey(name: 'location') String? location,
      @JsonKey(name: 'duration') String? duration,
      @JsonKey(name: 'certificate') String? certificate});
}

/// @nodoc
class __$LearningTypeCopyWithImpl<$Res>
    implements _$LearningTypeCopyWith<$Res> {
  __$LearningTypeCopyWithImpl(this._self, this._then);

  final _LearningType _self;
  final $Res Function(_LearningType) _then;

  /// Create a copy of LearningType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? price = null,
    Object? dateInfo = freezed,
    Object? location = freezed,
    Object? duration = freezed,
    Object? certificate = freezed,
  }) {
    return _then(_LearningType(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      dateInfo: freezed == dateInfo
          ? _self.dateInfo
          : dateInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      certificate: freezed == certificate
          ? _self.certificate
          : certificate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
