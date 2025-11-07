// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promocode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PromoCode {
  int get id;
  String get documentId;
  String get description;
  String get code;
  String get discountType;
  double get discountValue;
  int get maxUses;
  int get currentUses;
  DateTime get validUntil;

  /// Create a copy of PromoCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PromoCodeCopyWith<PromoCode> get copyWith =>
      _$PromoCodeCopyWithImpl<PromoCode>(this as PromoCode, _$identity);

  /// Serializes this PromoCode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PromoCode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.maxUses, maxUses) || other.maxUses == maxUses) &&
            (identical(other.currentUses, currentUses) ||
                other.currentUses == currentUses) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, documentId, description,
      code, discountType, discountValue, maxUses, currentUses, validUntil);

  @override
  String toString() {
    return 'PromoCode(id: $id, documentId: $documentId, description: $description, code: $code, discountType: $discountType, discountValue: $discountValue, maxUses: $maxUses, currentUses: $currentUses, validUntil: $validUntil)';
  }
}

/// @nodoc
abstract mixin class $PromoCodeCopyWith<$Res> {
  factory $PromoCodeCopyWith(PromoCode value, $Res Function(PromoCode) _then) =
      _$PromoCodeCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String documentId,
      String description,
      String code,
      String discountType,
      double discountValue,
      int maxUses,
      int currentUses,
      DateTime validUntil});
}

/// @nodoc
class _$PromoCodeCopyWithImpl<$Res> implements $PromoCodeCopyWith<$Res> {
  _$PromoCodeCopyWithImpl(this._self, this._then);

  final PromoCode _self;
  final $Res Function(PromoCode) _then;

  /// Create a copy of PromoCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? description = null,
    Object? code = null,
    Object? discountType = null,
    Object? discountValue = null,
    Object? maxUses = null,
    Object? currentUses = null,
    Object? validUntil = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      discountType: null == discountType
          ? _self.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String,
      discountValue: null == discountValue
          ? _self.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxUses: null == maxUses
          ? _self.maxUses
          : maxUses // ignore: cast_nullable_to_non_nullable
              as int,
      currentUses: null == currentUses
          ? _self.currentUses
          : currentUses // ignore: cast_nullable_to_non_nullable
              as int,
      validUntil: null == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [PromoCode].
extension PromoCodePatterns on PromoCode {
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
    TResult Function(_PromoCode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PromoCode() when $default != null:
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
    TResult Function(_PromoCode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PromoCode():
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
    TResult? Function(_PromoCode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PromoCode() when $default != null:
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
            String documentId,
            String description,
            String code,
            String discountType,
            double discountValue,
            int maxUses,
            int currentUses,
            DateTime validUntil)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PromoCode() when $default != null:
        return $default(
            _that.id,
            _that.documentId,
            _that.description,
            _that.code,
            _that.discountType,
            _that.discountValue,
            _that.maxUses,
            _that.currentUses,
            _that.validUntil);
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
            String documentId,
            String description,
            String code,
            String discountType,
            double discountValue,
            int maxUses,
            int currentUses,
            DateTime validUntil)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PromoCode():
        return $default(
            _that.id,
            _that.documentId,
            _that.description,
            _that.code,
            _that.discountType,
            _that.discountValue,
            _that.maxUses,
            _that.currentUses,
            _that.validUntil);
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
            String documentId,
            String description,
            String code,
            String discountType,
            double discountValue,
            int maxUses,
            int currentUses,
            DateTime validUntil)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PromoCode() when $default != null:
        return $default(
            _that.id,
            _that.documentId,
            _that.description,
            _that.code,
            _that.discountType,
            _that.discountValue,
            _that.maxUses,
            _that.currentUses,
            _that.validUntil);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PromoCode implements PromoCode {
  const _PromoCode(
      {required this.id,
      required this.documentId,
      required this.description,
      required this.code,
      required this.discountType,
      required this.discountValue,
      required this.maxUses,
      required this.currentUses,
      required this.validUntil});
  factory _PromoCode.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeFromJson(json);

  @override
  final int id;
  @override
  final String documentId;
  @override
  final String description;
  @override
  final String code;
  @override
  final String discountType;
  @override
  final double discountValue;
  @override
  final int maxUses;
  @override
  final int currentUses;
  @override
  final DateTime validUntil;

  /// Create a copy of PromoCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PromoCodeCopyWith<_PromoCode> get copyWith =>
      __$PromoCodeCopyWithImpl<_PromoCode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PromoCodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PromoCode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.maxUses, maxUses) || other.maxUses == maxUses) &&
            (identical(other.currentUses, currentUses) ||
                other.currentUses == currentUses) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, documentId, description,
      code, discountType, discountValue, maxUses, currentUses, validUntil);

  @override
  String toString() {
    return 'PromoCode(id: $id, documentId: $documentId, description: $description, code: $code, discountType: $discountType, discountValue: $discountValue, maxUses: $maxUses, currentUses: $currentUses, validUntil: $validUntil)';
  }
}

/// @nodoc
abstract mixin class _$PromoCodeCopyWith<$Res>
    implements $PromoCodeCopyWith<$Res> {
  factory _$PromoCodeCopyWith(
          _PromoCode value, $Res Function(_PromoCode) _then) =
      __$PromoCodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String documentId,
      String description,
      String code,
      String discountType,
      double discountValue,
      int maxUses,
      int currentUses,
      DateTime validUntil});
}

/// @nodoc
class __$PromoCodeCopyWithImpl<$Res> implements _$PromoCodeCopyWith<$Res> {
  __$PromoCodeCopyWithImpl(this._self, this._then);

  final _PromoCode _self;
  final $Res Function(_PromoCode) _then;

  /// Create a copy of PromoCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? documentId = null,
    Object? description = null,
    Object? code = null,
    Object? discountType = null,
    Object? discountValue = null,
    Object? maxUses = null,
    Object? currentUses = null,
    Object? validUntil = null,
  }) {
    return _then(_PromoCode(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      documentId: null == documentId
          ? _self.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      discountType: null == discountType
          ? _self.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String,
      discountValue: null == discountValue
          ? _self.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxUses: null == maxUses
          ? _self.maxUses
          : maxUses // ignore: cast_nullable_to_non_nullable
              as int,
      currentUses: null == currentUses
          ? _self.currentUses
          : currentUses // ignore: cast_nullable_to_non_nullable
              as int,
      validUntil: null == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
