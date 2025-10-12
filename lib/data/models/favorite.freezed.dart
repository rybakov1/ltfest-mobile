// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Favorite {
  int get id;
  String get title;
  String get type;
  @JsonKey(name: 'date_start')
  String get dateStart;
  @JsonKey(name: 'date_end')
  String get dateEnd;
  String? get image;
  String? get address;
  Direction? get direction;

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FavoriteCopyWith<Favorite> get copyWith =>
      _$FavoriteCopyWithImpl<Favorite>(this as Favorite, _$identity);

  /// Serializes this Favorite to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Favorite &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.dateStart, dateStart) ||
                other.dateStart == dateStart) &&
            (identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, type, dateStart,
      dateEnd, image, address, direction);

  @override
  String toString() {
    return 'Favorite(id: $id, title: $title, type: $type, dateStart: $dateStart, dateEnd: $dateEnd, image: $image, address: $address, direction: $direction)';
  }
}

/// @nodoc
abstract mixin class $FavoriteCopyWith<$Res> {
  factory $FavoriteCopyWith(Favorite value, $Res Function(Favorite) _then) =
      _$FavoriteCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String type,
      @JsonKey(name: 'date_start') String dateStart,
      @JsonKey(name: 'date_end') String dateEnd,
      String? image,
      String? address,
      Direction? direction});

  $DirectionCopyWith<$Res>? get direction;
}

/// @nodoc
class _$FavoriteCopyWithImpl<$Res> implements $FavoriteCopyWith<$Res> {
  _$FavoriteCopyWithImpl(this._self, this._then);

  final Favorite _self;
  final $Res Function(Favorite) _then;

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? dateStart = null,
    Object? dateEnd = null,
    Object? image = freezed,
    Object? address = freezed,
    Object? direction = freezed,
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
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      dateStart: null == dateStart
          ? _self.dateStart
          : dateStart // ignore: cast_nullable_to_non_nullable
              as String,
      dateEnd: null == dateEnd
          ? _self.dateEnd
          : dateEnd // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
    ));
  }

  /// Create a copy of Favorite
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

/// Adds pattern-matching-related methods to [Favorite].
extension FavoritePatterns on Favorite {
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
    TResult Function(_Favorite value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Favorite() when $default != null:
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
    TResult Function(_Favorite value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Favorite():
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
    TResult? Function(_Favorite value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Favorite() when $default != null:
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
            String type,
            @JsonKey(name: 'date_start') String dateStart,
            @JsonKey(name: 'date_end') String dateEnd,
            String? image,
            String? address,
            Direction? direction)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Favorite() when $default != null:
        return $default(_that.id, _that.title, _that.type, _that.dateStart,
            _that.dateEnd, _that.image, _that.address, _that.direction);
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
            String type,
            @JsonKey(name: 'date_start') String dateStart,
            @JsonKey(name: 'date_end') String dateEnd,
            String? image,
            String? address,
            Direction? direction)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Favorite():
        return $default(_that.id, _that.title, _that.type, _that.dateStart,
            _that.dateEnd, _that.image, _that.address, _that.direction);
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
            String type,
            @JsonKey(name: 'date_start') String dateStart,
            @JsonKey(name: 'date_end') String dateEnd,
            String? image,
            String? address,
            Direction? direction)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Favorite() when $default != null:
        return $default(_that.id, _that.title, _that.type, _that.dateStart,
            _that.dateEnd, _that.image, _that.address, _that.direction);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Favorite implements Favorite {
  const _Favorite(
      {required this.id,
      required this.title,
      required this.type,
      @JsonKey(name: 'date_start') required this.dateStart,
      @JsonKey(name: 'date_end') required this.dateEnd,
      this.image,
      this.address,
      this.direction});
  factory _Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String type;
  @override
  @JsonKey(name: 'date_start')
  final String dateStart;
  @override
  @JsonKey(name: 'date_end')
  final String dateEnd;
  @override
  final String? image;
  @override
  final String? address;
  @override
  final Direction? direction;

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FavoriteCopyWith<_Favorite> get copyWith =>
      __$FavoriteCopyWithImpl<_Favorite>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FavoriteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Favorite &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.dateStart, dateStart) ||
                other.dateStart == dateStart) &&
            (identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, type, dateStart,
      dateEnd, image, address, direction);

  @override
  String toString() {
    return 'Favorite(id: $id, title: $title, type: $type, dateStart: $dateStart, dateEnd: $dateEnd, image: $image, address: $address, direction: $direction)';
  }
}

/// @nodoc
abstract mixin class _$FavoriteCopyWith<$Res>
    implements $FavoriteCopyWith<$Res> {
  factory _$FavoriteCopyWith(_Favorite value, $Res Function(_Favorite) _then) =
      __$FavoriteCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String type,
      @JsonKey(name: 'date_start') String dateStart,
      @JsonKey(name: 'date_end') String dateEnd,
      String? image,
      String? address,
      Direction? direction});

  @override
  $DirectionCopyWith<$Res>? get direction;
}

/// @nodoc
class __$FavoriteCopyWithImpl<$Res> implements _$FavoriteCopyWith<$Res> {
  __$FavoriteCopyWithImpl(this._self, this._then);

  final _Favorite _self;
  final $Res Function(_Favorite) _then;

  /// Create a copy of Favorite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? dateStart = null,
    Object? dateEnd = null,
    Object? image = freezed,
    Object? address = freezed,
    Object? direction = freezed,
  }) {
    return _then(_Favorite(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      dateStart: null == dateStart
          ? _self.dateStart
          : dateStart // ignore: cast_nullable_to_non_nullable
              as String,
      dateEnd: null == dateEnd
          ? _self.dateEnd
          : dateEnd // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
    ));
  }

  /// Create a copy of Favorite
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
