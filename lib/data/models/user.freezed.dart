// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {
  int get id;
  String? get firstname;
  String? get lastname;
  String? get email;
  DateTime? get birthdate;
  String? get residence;
  String? get phone;
  Activity? get activity;
  Direction? get direction;
  String? get collectiveName;
  String? get collectiveCity;
  String? get ltpriority;
  String? get educationPlace;
  String? get masterName;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserCopyWith<User> get copyWith =>
      _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.residence, residence) ||
                other.residence == residence) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.collectiveName, collectiveName) ||
                other.collectiveName == collectiveName) &&
            (identical(other.collectiveCity, collectiveCity) ||
                other.collectiveCity == collectiveCity) &&
            (identical(other.ltpriority, ltpriority) ||
                other.ltpriority == ltpriority) &&
            (identical(other.educationPlace, educationPlace) ||
                other.educationPlace == educationPlace) &&
            (identical(other.masterName, masterName) ||
                other.masterName == masterName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstname,
      lastname,
      email,
      birthdate,
      residence,
      phone,
      activity,
      direction,
      collectiveName,
      collectiveCity,
      ltpriority,
      educationPlace,
      masterName);

  @override
  String toString() {
    return 'User(id: $id, firstname: $firstname, lastname: $lastname, email: $email, birthdate: $birthdate, residence: $residence, phone: $phone, activity: $activity, direction: $direction, collectiveName: $collectiveName, collectiveCity: $collectiveCity, ltpriority: $ltpriority, educationPlace: $educationPlace, masterName: $masterName)';
  }
}

/// @nodoc
abstract mixin class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) _then) =
      _$UserCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String? firstname,
      String? lastname,
      String? email,
      DateTime? birthdate,
      String? residence,
      String? phone,
      Activity? activity,
      Direction? direction,
      String? collectiveName,
      String? collectiveCity,
      String? ltpriority,
      String? educationPlace,
      String? masterName});

  $ActivityCopyWith<$Res>? get activity;
  $DirectionCopyWith<$Res>? get direction;
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstname = freezed,
    Object? lastname = freezed,
    Object? email = freezed,
    Object? birthdate = freezed,
    Object? residence = freezed,
    Object? phone = freezed,
    Object? activity = freezed,
    Object? direction = freezed,
    Object? collectiveName = freezed,
    Object? collectiveCity = freezed,
    Object? ltpriority = freezed,
    Object? educationPlace = freezed,
    Object? masterName = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstname: freezed == firstname
          ? _self.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname: freezed == lastname
          ? _self.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _self.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      residence: freezed == residence
          ? _self.residence
          : residence // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      activity: freezed == activity
          ? _self.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as Activity?,
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
      collectiveName: freezed == collectiveName
          ? _self.collectiveName
          : collectiveName // ignore: cast_nullable_to_non_nullable
              as String?,
      collectiveCity: freezed == collectiveCity
          ? _self.collectiveCity
          : collectiveCity // ignore: cast_nullable_to_non_nullable
              as String?,
      ltpriority: freezed == ltpriority
          ? _self.ltpriority
          : ltpriority // ignore: cast_nullable_to_non_nullable
              as String?,
      educationPlace: freezed == educationPlace
          ? _self.educationPlace
          : educationPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      masterName: freezed == masterName
          ? _self.masterName
          : masterName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityCopyWith<$Res>? get activity {
    if (_self.activity == null) {
      return null;
    }

    return $ActivityCopyWith<$Res>(_self.activity!, (value) {
      return _then(_self.copyWith(activity: value));
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<$Res>? get direction {
    if (_self.direction == null) {
      return null;
    }

    return $DirectionCopyWith<$Res>(_self.direction!, (value) {
      return _then(_self.copyWith(direction: value));
    });
  }
}

/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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
    TResult Function(_User value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
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
    TResult Function(_User value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User():
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
    TResult? Function(_User value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
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
            String? firstname,
            String? lastname,
            String? email,
            DateTime? birthdate,
            String? residence,
            String? phone,
            Activity? activity,
            Direction? direction,
            String? collectiveName,
            String? collectiveCity,
            String? ltpriority,
            String? educationPlace,
            String? masterName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
        return $default(
            _that.id,
            _that.firstname,
            _that.lastname,
            _that.email,
            _that.birthdate,
            _that.residence,
            _that.phone,
            _that.activity,
            _that.direction,
            _that.collectiveName,
            _that.collectiveCity,
            _that.ltpriority,
            _that.educationPlace,
            _that.masterName);
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
            String? firstname,
            String? lastname,
            String? email,
            DateTime? birthdate,
            String? residence,
            String? phone,
            Activity? activity,
            Direction? direction,
            String? collectiveName,
            String? collectiveCity,
            String? ltpriority,
            String? educationPlace,
            String? masterName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User():
        return $default(
            _that.id,
            _that.firstname,
            _that.lastname,
            _that.email,
            _that.birthdate,
            _that.residence,
            _that.phone,
            _that.activity,
            _that.direction,
            _that.collectiveName,
            _that.collectiveCity,
            _that.ltpriority,
            _that.educationPlace,
            _that.masterName);
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
            String? firstname,
            String? lastname,
            String? email,
            DateTime? birthdate,
            String? residence,
            String? phone,
            Activity? activity,
            Direction? direction,
            String? collectiveName,
            String? collectiveCity,
            String? ltpriority,
            String? educationPlace,
            String? masterName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
        return $default(
            _that.id,
            _that.firstname,
            _that.lastname,
            _that.email,
            _that.birthdate,
            _that.residence,
            _that.phone,
            _that.activity,
            _that.direction,
            _that.collectiveName,
            _that.collectiveCity,
            _that.ltpriority,
            _that.educationPlace,
            _that.masterName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _User implements User {
  const _User(
      {required this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.birthdate,
      this.residence,
      this.phone,
      this.activity,
      this.direction,
      this.collectiveName,
      this.collectiveCity,
      this.ltpriority,
      this.educationPlace,
      this.masterName});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  final int id;
  @override
  final String? firstname;
  @override
  final String? lastname;
  @override
  final String? email;
  @override
  final DateTime? birthdate;
  @override
  final String? residence;
  @override
  final String? phone;
  @override
  final Activity? activity;
  @override
  final Direction? direction;
  @override
  final String? collectiveName;
  @override
  final String? collectiveCity;
  @override
  final String? ltpriority;
  @override
  final String? educationPlace;
  @override
  final String? masterName;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.residence, residence) ||
                other.residence == residence) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.collectiveName, collectiveName) ||
                other.collectiveName == collectiveName) &&
            (identical(other.collectiveCity, collectiveCity) ||
                other.collectiveCity == collectiveCity) &&
            (identical(other.ltpriority, ltpriority) ||
                other.ltpriority == ltpriority) &&
            (identical(other.educationPlace, educationPlace) ||
                other.educationPlace == educationPlace) &&
            (identical(other.masterName, masterName) ||
                other.masterName == masterName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstname,
      lastname,
      email,
      birthdate,
      residence,
      phone,
      activity,
      direction,
      collectiveName,
      collectiveCity,
      ltpriority,
      educationPlace,
      masterName);

  @override
  String toString() {
    return 'User(id: $id, firstname: $firstname, lastname: $lastname, email: $email, birthdate: $birthdate, residence: $residence, phone: $phone, activity: $activity, direction: $direction, collectiveName: $collectiveName, collectiveCity: $collectiveCity, ltpriority: $ltpriority, educationPlace: $educationPlace, masterName: $masterName)';
  }
}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) =
      __$UserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String? firstname,
      String? lastname,
      String? email,
      DateTime? birthdate,
      String? residence,
      String? phone,
      Activity? activity,
      Direction? direction,
      String? collectiveName,
      String? collectiveCity,
      String? ltpriority,
      String? educationPlace,
      String? masterName});

  @override
  $ActivityCopyWith<$Res>? get activity;
  @override
  $DirectionCopyWith<$Res>? get direction;
}

/// @nodoc
class __$UserCopyWithImpl<$Res> implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? firstname = freezed,
    Object? lastname = freezed,
    Object? email = freezed,
    Object? birthdate = freezed,
    Object? residence = freezed,
    Object? phone = freezed,
    Object? activity = freezed,
    Object? direction = freezed,
    Object? collectiveName = freezed,
    Object? collectiveCity = freezed,
    Object? ltpriority = freezed,
    Object? educationPlace = freezed,
    Object? masterName = freezed,
  }) {
    return _then(_User(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstname: freezed == firstname
          ? _self.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname: freezed == lastname
          ? _self.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _self.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      residence: freezed == residence
          ? _self.residence
          : residence // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      activity: freezed == activity
          ? _self.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as Activity?,
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
      collectiveName: freezed == collectiveName
          ? _self.collectiveName
          : collectiveName // ignore: cast_nullable_to_non_nullable
              as String?,
      collectiveCity: freezed == collectiveCity
          ? _self.collectiveCity
          : collectiveCity // ignore: cast_nullable_to_non_nullable
              as String?,
      ltpriority: freezed == ltpriority
          ? _self.ltpriority
          : ltpriority // ignore: cast_nullable_to_non_nullable
              as String?,
      educationPlace: freezed == educationPlace
          ? _self.educationPlace
          : educationPlace // ignore: cast_nullable_to_non_nullable
              as String?,
      masterName: freezed == masterName
          ? _self.masterName
          : masterName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityCopyWith<$Res>? get activity {
    if (_self.activity == null) {
      return null;
    }

    return $ActivityCopyWith<$Res>(_self.activity!, (value) {
      return _then(_self.copyWith(activity: value));
    });
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<$Res>? get direction {
    if (_self.direction == null) {
      return null;
    }

    return $DirectionCopyWith<$Res>(_self.direction!, (value) {
      return _then(_self.copyWith(direction: value));
    });
  }
}

// dart format on
