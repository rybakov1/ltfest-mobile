// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
  String? get image;
  int get price;
  String get date;
  String? get address;
  String? get description;
  String? get pdfurl;
  @JsonKey(name: 'direction')
  Direction get direction;
  List<Jury> get jury;

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
            (identical(other.image, image) || other.image == image) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pdfurl, pdfurl) || other.pdfurl == pdfurl) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            const DeepCollectionEquality().equals(other.jury, jury));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      image,
      price,
      date,
      address,
      description,
      pdfurl,
      direction,
      const DeepCollectionEquality().hash(jury));

  @override
  String toString() {
    return 'Festival(id: $id, title: $title, image: $image, price: $price, date: $date, address: $address, description: $description, pdfurl: $pdfurl, direction: $direction, jury: $jury)';
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
      String? image,
      int price,
      String date,
      String? address,
      String? description,
      String? pdfurl,
      @JsonKey(name: 'direction') Direction direction,
      List<Jury> jury});

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
    Object? image = freezed,
    Object? price = null,
    Object? date = null,
    Object? address = freezed,
    Object? description = freezed,
    Object? pdfurl = freezed,
    Object? direction = null,
    Object? jury = null,
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
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
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
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      jury: null == jury
          ? _self.jury
          : jury // ignore: cast_nullable_to_non_nullable
              as List<Jury>,
    ));
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

/// @nodoc
@JsonSerializable()
class _Festival implements Festival {
  const _Festival(
      {required this.id,
      required this.title,
      this.image,
      required this.price,
      required this.date,
      this.address,
      this.description,
      this.pdfurl,
      @JsonKey(name: 'direction') required this.direction,
      required final List<Jury> jury})
      : _jury = jury;
  factory _Festival.fromJson(Map<String, dynamic> json) =>
      _$FestivalFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? image;
  @override
  final int price;
  @override
  final String date;
  @override
  final String? address;
  @override
  final String? description;
  @override
  final String? pdfurl;
  @override
  @JsonKey(name: 'direction')
  final Direction direction;
  final List<Jury> _jury;
  @override
  List<Jury> get jury {
    if (_jury is EqualUnmodifiableListView) return _jury;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_jury);
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
            (identical(other.image, image) || other.image == image) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pdfurl, pdfurl) || other.pdfurl == pdfurl) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            const DeepCollectionEquality().equals(other._jury, _jury));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      image,
      price,
      date,
      address,
      description,
      pdfurl,
      direction,
      const DeepCollectionEquality().hash(_jury));

  @override
  String toString() {
    return 'Festival(id: $id, title: $title, image: $image, price: $price, date: $date, address: $address, description: $description, pdfurl: $pdfurl, direction: $direction, jury: $jury)';
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
      String? image,
      int price,
      String date,
      String? address,
      String? description,
      String? pdfurl,
      @JsonKey(name: 'direction') Direction direction,
      List<Jury> jury});

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
    Object? image = freezed,
    Object? price = null,
    Object? date = null,
    Object? address = freezed,
    Object? description = freezed,
    Object? pdfurl = freezed,
    Object? direction = null,
    Object? jury = null,
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
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
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
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      jury: null == jury
          ? _self._jury
          : jury // ignore: cast_nullable_to_non_nullable
              as List<Jury>,
    ));
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
