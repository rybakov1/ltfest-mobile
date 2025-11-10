// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loyalty_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoyaltyCard {
  int get id;
  String get cardStatus;
  DateTime get validFrom;
  DateTime get validUntil;
  String get cardNumber;
  int get discountPercent;
  User get user;

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoyaltyCardCopyWith<LoyaltyCard> get copyWith =>
      _$LoyaltyCardCopyWithImpl<LoyaltyCard>(this as LoyaltyCard, _$identity);

  /// Serializes this LoyaltyCard to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoyaltyCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cardStatus, cardStatus) ||
                other.cardStatus == cardStatus) &&
            (identical(other.validFrom, validFrom) ||
                other.validFrom == validFrom) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, cardStatus, validFrom,
      validUntil, cardNumber, discountPercent, user);

  @override
  String toString() {
    return 'LoyaltyCard(id: $id, cardStatus: $cardStatus, validFrom: $validFrom, validUntil: $validUntil, cardNumber: $cardNumber, discountPercent: $discountPercent, user: $user)';
  }
}

/// @nodoc
abstract mixin class $LoyaltyCardCopyWith<$Res> {
  factory $LoyaltyCardCopyWith(
          LoyaltyCard value, $Res Function(LoyaltyCard) _then) =
      _$LoyaltyCardCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String cardStatus,
      DateTime validFrom,
      DateTime validUntil,
      String cardNumber,
      int discountPercent,
      User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$LoyaltyCardCopyWithImpl<$Res> implements $LoyaltyCardCopyWith<$Res> {
  _$LoyaltyCardCopyWithImpl(this._self, this._then);

  final LoyaltyCard _self;
  final $Res Function(LoyaltyCard) _then;

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cardStatus = null,
    Object? validFrom = null,
    Object? validUntil = null,
    Object? cardNumber = null,
    Object? discountPercent = null,
    Object? user = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cardStatus: null == cardStatus
          ? _self.cardStatus
          : cardStatus // ignore: cast_nullable_to_non_nullable
              as String,
      validFrom: null == validFrom
          ? _self.validFrom
          : validFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validUntil: null == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cardNumber: null == cardNumber
          ? _self.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      discountPercent: null == discountPercent
          ? _self.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [LoyaltyCard].
extension LoyaltyCardPatterns on LoyaltyCard {
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
    TResult Function(_LoyaltyCard value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoyaltyCard() when $default != null:
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
    TResult Function(_LoyaltyCard value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoyaltyCard():
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
    TResult? Function(_LoyaltyCard value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoyaltyCard() when $default != null:
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
            String cardStatus,
            DateTime validFrom,
            DateTime validUntil,
            String cardNumber,
            int discountPercent,
            User user)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoyaltyCard() when $default != null:
        return $default(
            _that.id,
            _that.cardStatus,
            _that.validFrom,
            _that.validUntil,
            _that.cardNumber,
            _that.discountPercent,
            _that.user);
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
            String cardStatus,
            DateTime validFrom,
            DateTime validUntil,
            String cardNumber,
            int discountPercent,
            User user)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoyaltyCard():
        return $default(
            _that.id,
            _that.cardStatus,
            _that.validFrom,
            _that.validUntil,
            _that.cardNumber,
            _that.discountPercent,
            _that.user);
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
            String cardStatus,
            DateTime validFrom,
            DateTime validUntil,
            String cardNumber,
            int discountPercent,
            User user)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoyaltyCard() when $default != null:
        return $default(
            _that.id,
            _that.cardStatus,
            _that.validFrom,
            _that.validUntil,
            _that.cardNumber,
            _that.discountPercent,
            _that.user);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LoyaltyCard implements LoyaltyCard {
  const _LoyaltyCard(
      {required this.id,
      required this.cardStatus,
      required this.validFrom,
      required this.validUntil,
      required this.cardNumber,
      required this.discountPercent,
      required this.user});
  factory _LoyaltyCard.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyCardFromJson(json);

  @override
  final int id;
  @override
  final String cardStatus;
  @override
  final DateTime validFrom;
  @override
  final DateTime validUntil;
  @override
  final String cardNumber;
  @override
  final int discountPercent;
  @override
  final User user;

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoyaltyCardCopyWith<_LoyaltyCard> get copyWith =>
      __$LoyaltyCardCopyWithImpl<_LoyaltyCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoyaltyCardToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoyaltyCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cardStatus, cardStatus) ||
                other.cardStatus == cardStatus) &&
            (identical(other.validFrom, validFrom) ||
                other.validFrom == validFrom) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, cardStatus, validFrom,
      validUntil, cardNumber, discountPercent, user);

  @override
  String toString() {
    return 'LoyaltyCard(id: $id, cardStatus: $cardStatus, validFrom: $validFrom, validUntil: $validUntil, cardNumber: $cardNumber, discountPercent: $discountPercent, user: $user)';
  }
}

/// @nodoc
abstract mixin class _$LoyaltyCardCopyWith<$Res>
    implements $LoyaltyCardCopyWith<$Res> {
  factory _$LoyaltyCardCopyWith(
          _LoyaltyCard value, $Res Function(_LoyaltyCard) _then) =
      __$LoyaltyCardCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String cardStatus,
      DateTime validFrom,
      DateTime validUntil,
      String cardNumber,
      int discountPercent,
      User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$LoyaltyCardCopyWithImpl<$Res> implements _$LoyaltyCardCopyWith<$Res> {
  __$LoyaltyCardCopyWithImpl(this._self, this._then);

  final _LoyaltyCard _self;
  final $Res Function(_LoyaltyCard) _then;

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? cardStatus = null,
    Object? validFrom = null,
    Object? validUntil = null,
    Object? cardNumber = null,
    Object? discountPercent = null,
    Object? user = null,
  }) {
    return _then(_LoyaltyCard(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cardStatus: null == cardStatus
          ? _self.cardStatus
          : cardStatus // ignore: cast_nullable_to_non_nullable
              as String,
      validFrom: null == validFrom
          ? _self.validFrom
          : validFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validUntil: null == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cardNumber: null == cardNumber
          ? _self.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      discountPercent: null == discountPercent
          ? _self.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of LoyaltyCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
