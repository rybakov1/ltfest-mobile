// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'festival.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Festival {
  int get id;
  String get title;
  String? get title2;
  ImageData? get image;
  int get price;
  @JsonKey(name: "date_start")
  DateTime? get dateStart;
  @JsonKey(name: "date_end")
  DateTime? get dateEnd;
  String? get address;
  String? get description;
  String? get pdfurl;
  String? get entryurl;
  String? get websiteurl;
  Direction get direction;
  List<Person>? get persons;

  /// Create a copy of Festival
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FestivalCopyWith<Festival> get copyWith =>
      _$FestivalCopyWithImpl<Festival>(this as Festival, _$identity);

  /// Serializes this Festival to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Festival &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.title2, title2) || other.title2 == title2) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.dateStart, dateStart) ||
                other.dateStart == dateStart) &&
            (identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pdfurl, pdfurl) || other.pdfurl == pdfurl) &&
            (identical(other.entryurl, entryurl) ||
                other.entryurl == entryurl) &&
            (identical(other.websiteurl, websiteurl) ||
                other.websiteurl == websiteurl) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            const DeepCollectionEquality().equals(other.persons, persons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      title2,
      image,
      price,
      dateStart,
      dateEnd,
      address,
      description,
      pdfurl,
      entryurl,
      websiteurl,
      direction,
      const DeepCollectionEquality().hash(persons));

  @override
  String toString() {
    return 'Festival(id: $id, title: $title, title2: $title2, image: $image, price: $price, dateStart: $dateStart, dateEnd: $dateEnd, address: $address, description: $description, pdfurl: $pdfurl, entryurl: $entryurl, websiteurl: $websiteurl, direction: $direction, persons: $persons)';
  }
}

/// @nodoc
abstract mixin class $FestivalCopyWith<$Res> {
  factory $FestivalCopyWith(Festival value, $Res Function(Festival) _then) =
      _$FestivalCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String? title2,
      ImageData? image,
      int price,
      @JsonKey(name: "date_start") DateTime? dateStart,
      @JsonKey(name: "date_end") DateTime? dateEnd,
      String? address,
      String? description,
      String? pdfurl,
      String? entryurl,
      String? websiteurl,
      Direction direction,
      List<Person>? persons});

  $ImageDataCopyWith<$Res>? get image;
  $DirectionCopyWith<$Res> get direction;
}

/// @nodoc
class _$FestivalCopyWithImpl<$Res> implements $FestivalCopyWith<$Res> {
  _$FestivalCopyWithImpl(this._self, this._then);

  final Festival _self;
  final $Res Function(Festival) _then;

  /// Create a copy of Festival
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? title2 = freezed,
    Object? image = freezed,
    Object? price = null,
    Object? dateStart = freezed,
    Object? dateEnd = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? pdfurl = freezed,
    Object? entryurl = freezed,
    Object? websiteurl = freezed,
    Object? direction = null,
    Object? persons = freezed,
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
      title2: freezed == title2
          ? _self.title2
          : title2 // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as ImageData?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      dateStart: freezed == dateStart
          ? _self.dateStart
          : dateStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateEnd: freezed == dateEnd
          ? _self.dateEnd
          : dateEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      pdfurl: freezed == pdfurl
          ? _self.pdfurl
          : pdfurl // ignore: cast_nullable_to_non_nullable
              as String?,
      entryurl: freezed == entryurl
          ? _self.entryurl
          : entryurl // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteurl: freezed == websiteurl
          ? _self.websiteurl
          : websiteurl // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      persons: freezed == persons
          ? _self.persons
          : persons // ignore: cast_nullable_to_non_nullable
              as List<Person>?,
    ));
  }

  /// Create a copy of Festival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDataCopyWith<$Res>? get image {
    if (_self.image == null) {
      return null;
    }

    return $ImageDataCopyWith<$Res>(_self.image!, (value) {
      return _then(_self.copyWith(image: value));
    });
  }

  /// Create a copy of Festival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<$Res> get direction {
    return $DirectionCopyWith<$Res>(_self.direction, (value) {
      return _then(_self.copyWith(direction: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Festival].
extension FestivalPatterns on Festival {
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
    TResult Function(_Festival value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Festival() when $default != null:
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
    TResult Function(_Festival value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Festival():
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
    TResult? Function(_Festival value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Festival() when $default != null:
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
            String? title2,
            ImageData? image,
            int price,
            @JsonKey(name: "date_start") DateTime? dateStart,
            @JsonKey(name: "date_end") DateTime? dateEnd,
            String? address,
            String? description,
            String? pdfurl,
            String? entryurl,
            String? websiteurl,
            Direction direction,
            List<Person>? persons)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Festival() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.title2,
            _that.image,
            _that.price,
            _that.dateStart,
            _that.dateEnd,
            _that.address,
            _that.description,
            _that.pdfurl,
            _that.entryurl,
            _that.websiteurl,
            _that.direction,
            _that.persons);
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
            String? title2,
            ImageData? image,
            int price,
            @JsonKey(name: "date_start") DateTime? dateStart,
            @JsonKey(name: "date_end") DateTime? dateEnd,
            String? address,
            String? description,
            String? pdfurl,
            String? entryurl,
            String? websiteurl,
            Direction direction,
            List<Person>? persons)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Festival():
        return $default(
            _that.id,
            _that.title,
            _that.title2,
            _that.image,
            _that.price,
            _that.dateStart,
            _that.dateEnd,
            _that.address,
            _that.description,
            _that.pdfurl,
            _that.entryurl,
            _that.websiteurl,
            _that.direction,
            _that.persons);
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
            String? title2,
            ImageData? image,
            int price,
            @JsonKey(name: "date_start") DateTime? dateStart,
            @JsonKey(name: "date_end") DateTime? dateEnd,
            String? address,
            String? description,
            String? pdfurl,
            String? entryurl,
            String? websiteurl,
            Direction direction,
            List<Person>? persons)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Festival() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.title2,
            _that.image,
            _that.price,
            _that.dateStart,
            _that.dateEnd,
            _that.address,
            _that.description,
            _that.pdfurl,
            _that.entryurl,
            _that.websiteurl,
            _that.direction,
            _that.persons);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Festival implements Festival {
  const _Festival(
      {required this.id,
      required this.title,
      this.title2,
      this.image,
      required this.price,
      @JsonKey(name: "date_start") this.dateStart,
      @JsonKey(name: "date_end") this.dateEnd,
      this.address,
      this.description,
      this.pdfurl,
      this.entryurl,
      this.websiteurl,
      required this.direction,
      final List<Person>? persons})
      : _persons = persons;
  factory _Festival.fromJson(Map<String, dynamic> json) =>
      _$FestivalFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? title2;
  @override
  final ImageData? image;
  @override
  final int price;
  @override
  @JsonKey(name: "date_start")
  final DateTime? dateStart;
  @override
  @JsonKey(name: "date_end")
  final DateTime? dateEnd;
  @override
  final String? address;
  @override
  final String? description;
  @override
  final String? pdfurl;
  @override
  final String? entryurl;
  @override
  final String? websiteurl;
  @override
  final Direction direction;
  final List<Person>? _persons;
  @override
  List<Person>? get persons {
    final value = _persons;
    if (value == null) return null;
    if (_persons is EqualUnmodifiableListView) return _persons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Festival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FestivalCopyWith<_Festival> get copyWith =>
      __$FestivalCopyWithImpl<_Festival>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FestivalToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Festival &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.title2, title2) || other.title2 == title2) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.dateStart, dateStart) ||
                other.dateStart == dateStart) &&
            (identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pdfurl, pdfurl) || other.pdfurl == pdfurl) &&
            (identical(other.entryurl, entryurl) ||
                other.entryurl == entryurl) &&
            (identical(other.websiteurl, websiteurl) ||
                other.websiteurl == websiteurl) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            const DeepCollectionEquality().equals(other._persons, _persons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      title2,
      image,
      price,
      dateStart,
      dateEnd,
      address,
      description,
      pdfurl,
      entryurl,
      websiteurl,
      direction,
      const DeepCollectionEquality().hash(_persons));

  @override
  String toString() {
    return 'Festival(id: $id, title: $title, title2: $title2, image: $image, price: $price, dateStart: $dateStart, dateEnd: $dateEnd, address: $address, description: $description, pdfurl: $pdfurl, entryurl: $entryurl, websiteurl: $websiteurl, direction: $direction, persons: $persons)';
  }
}

/// @nodoc
abstract mixin class _$FestivalCopyWith<$Res>
    implements $FestivalCopyWith<$Res> {
  factory _$FestivalCopyWith(_Festival value, $Res Function(_Festival) _then) =
      __$FestivalCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? title2,
      ImageData? image,
      int price,
      @JsonKey(name: "date_start") DateTime? dateStart,
      @JsonKey(name: "date_end") DateTime? dateEnd,
      String? address,
      String? description,
      String? pdfurl,
      String? entryurl,
      String? websiteurl,
      Direction direction,
      List<Person>? persons});

  @override
  $ImageDataCopyWith<$Res>? get image;
  @override
  $DirectionCopyWith<$Res> get direction;
}

/// @nodoc
class __$FestivalCopyWithImpl<$Res> implements _$FestivalCopyWith<$Res> {
  __$FestivalCopyWithImpl(this._self, this._then);

  final _Festival _self;
  final $Res Function(_Festival) _then;

  /// Create a copy of Festival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? title2 = freezed,
    Object? image = freezed,
    Object? price = null,
    Object? dateStart = freezed,
    Object? dateEnd = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? pdfurl = freezed,
    Object? entryurl = freezed,
    Object? websiteurl = freezed,
    Object? direction = null,
    Object? persons = freezed,
  }) {
    return _then(_Festival(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      title2: freezed == title2
          ? _self.title2
          : title2 // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as ImageData?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      dateStart: freezed == dateStart
          ? _self.dateStart
          : dateStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateEnd: freezed == dateEnd
          ? _self.dateEnd
          : dateEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      pdfurl: freezed == pdfurl
          ? _self.pdfurl
          : pdfurl // ignore: cast_nullable_to_non_nullable
              as String?,
      entryurl: freezed == entryurl
          ? _self.entryurl
          : entryurl // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteurl: freezed == websiteurl
          ? _self.websiteurl
          : websiteurl // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      persons: freezed == persons
          ? _self._persons
          : persons // ignore: cast_nullable_to_non_nullable
              as List<Person>?,
    ));
  }

  /// Create a copy of Festival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDataCopyWith<$Res>? get image {
    if (_self.image == null) {
      return null;
    }

    return $ImageDataCopyWith<$Res>(_self.image!, (value) {
      return _then(_self.copyWith(image: value));
    });
  }

  /// Create a copy of Festival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<$Res> get direction {
    return $DirectionCopyWith<$Res>(_self.direction, (value) {
      return _then(_self.copyWith(direction: value));
    });
  }
}

// dart format on
