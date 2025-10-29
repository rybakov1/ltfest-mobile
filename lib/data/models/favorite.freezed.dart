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
  int get favoriteId;
  String get type;
  String get title;
  String? get image; // Поля для фестивалей и лабораторий
  String? get date_start;
  String? get date_end;
  String? get address;
  Direction? get direction; // Поля для продуктов
  double? get price;
  String? get article;

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
            (identical(other.favoriteId, favoriteId) ||
                other.favoriteId == favoriteId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.date_start, date_start) ||
                other.date_start == date_start) &&
            (identical(other.date_end, date_end) ||
                other.date_end == date_end) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.article, article) || other.article == article));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, favoriteId, type, title,
      image, date_start, date_end, address, direction, price, article);

  @override
  String toString() {
    return 'Favorite(id: $id, favoriteId: $favoriteId, type: $type, title: $title, image: $image, date_start: $date_start, date_end: $date_end, address: $address, direction: $direction, price: $price, article: $article)';
  }
}

/// @nodoc
abstract mixin class $FavoriteCopyWith<$Res> {
  factory $FavoriteCopyWith(Favorite value, $Res Function(Favorite) _then) =
      _$FavoriteCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int favoriteId,
      String type,
      String title,
      String? image,
      String? date_start,
      String? date_end,
      String? address,
      Direction? direction,
      double? price,
      String? article});

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
    Object? favoriteId = null,
    Object? type = null,
    Object? title = null,
    Object? image = freezed,
    Object? date_start = freezed,
    Object? date_end = freezed,
    Object? address = freezed,
    Object? direction = freezed,
    Object? price = freezed,
    Object? article = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteId: null == favoriteId
          ? _self.favoriteId
          : favoriteId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      date_start: freezed == date_start
          ? _self.date_start
          : date_start // ignore: cast_nullable_to_non_nullable
              as String?,
      date_end: freezed == date_end
          ? _self.date_end
          : date_end // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
      price: freezed == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      article: freezed == article
          ? _self.article
          : article // ignore: cast_nullable_to_non_nullable
              as String?,
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
            int favoriteId,
            String type,
            String title,
            String? image,
            String? date_start,
            String? date_end,
            String? address,
            Direction? direction,
            double? price,
            String? article)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Favorite() when $default != null:
        return $default(
            _that.id,
            _that.favoriteId,
            _that.type,
            _that.title,
            _that.image,
            _that.date_start,
            _that.date_end,
            _that.address,
            _that.direction,
            _that.price,
            _that.article);
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
            int favoriteId,
            String type,
            String title,
            String? image,
            String? date_start,
            String? date_end,
            String? address,
            Direction? direction,
            double? price,
            String? article)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Favorite():
        return $default(
            _that.id,
            _that.favoriteId,
            _that.type,
            _that.title,
            _that.image,
            _that.date_start,
            _that.date_end,
            _that.address,
            _that.direction,
            _that.price,
            _that.article);
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
            int favoriteId,
            String type,
            String title,
            String? image,
            String? date_start,
            String? date_end,
            String? address,
            Direction? direction,
            double? price,
            String? article)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Favorite() when $default != null:
        return $default(
            _that.id,
            _that.favoriteId,
            _that.type,
            _that.title,
            _that.image,
            _that.date_start,
            _that.date_end,
            _that.address,
            _that.direction,
            _that.price,
            _that.article);
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
      required this.favoriteId,
      required this.type,
      required this.title,
      this.image,
      this.date_start,
      this.date_end,
      this.address,
      this.direction,
      this.price,
      this.article});
  factory _Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  @override
  final int id;
  @override
  final int favoriteId;
  @override
  final String type;
  @override
  final String title;
  @override
  final String? image;
// Поля для фестивалей и лабораторий
  @override
  final String? date_start;
  @override
  final String? date_end;
  @override
  final String? address;
  @override
  final Direction? direction;
// Поля для продуктов
  @override
  final double? price;
  @override
  final String? article;

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
            (identical(other.favoriteId, favoriteId) ||
                other.favoriteId == favoriteId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.date_start, date_start) ||
                other.date_start == date_start) &&
            (identical(other.date_end, date_end) ||
                other.date_end == date_end) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.article, article) || other.article == article));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, favoriteId, type, title,
      image, date_start, date_end, address, direction, price, article);

  @override
  String toString() {
    return 'Favorite(id: $id, favoriteId: $favoriteId, type: $type, title: $title, image: $image, date_start: $date_start, date_end: $date_end, address: $address, direction: $direction, price: $price, article: $article)';
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
      int favoriteId,
      String type,
      String title,
      String? image,
      String? date_start,
      String? date_end,
      String? address,
      Direction? direction,
      double? price,
      String? article});

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
    Object? favoriteId = null,
    Object? type = null,
    Object? title = null,
    Object? image = freezed,
    Object? date_start = freezed,
    Object? date_end = freezed,
    Object? address = freezed,
    Object? direction = freezed,
    Object? price = freezed,
    Object? article = freezed,
  }) {
    return _then(_Favorite(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteId: null == favoriteId
          ? _self.favoriteId
          : favoriteId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      date_start: freezed == date_start
          ? _self.date_start
          : date_start // ignore: cast_nullable_to_non_nullable
              as String?,
      date_end: freezed == date_end
          ? _self.date_end
          : date_end // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
      price: freezed == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      article: freezed == article
          ? _self.article
          : article // ignore: cast_nullable_to_non_nullable
              as String?,
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
