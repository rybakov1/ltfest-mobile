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
      image,
      price,
      dateStart,
      dateEnd,
      address,
      description,
      pdfurl,
      entryurl,
      direction,
      const DeepCollectionEquality().hash(persons));

  @override
  String toString() {
    return 'Festival(id: $id, title: $title, image: $image, price: $price, dateStart: $dateStart, dateEnd: $dateEnd, address: $address, description: $description, pdfurl: $pdfurl, entryurl: $entryurl, direction: $direction, persons: $persons)';
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
      ImageData? image,
      int price,
      @JsonKey(name: "date_start") DateTime? dateStart,
      @JsonKey(name: "date_end") DateTime? dateEnd,
      String? address,
      String? description,
      String? pdfurl,
      String? entryurl,
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
    Object? image = freezed,
    Object? price = null,
    Object? dateStart = freezed,
    Object? dateEnd = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? pdfurl = freezed,
    Object? entryurl = freezed,
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

/// @nodoc
@JsonSerializable()
class _Festival implements Festival {
  const _Festival(
      {required this.id,
      required this.title,
      this.image,
      required this.price,
      @JsonKey(name: "date_start") this.dateStart,
      @JsonKey(name: "date_end") this.dateEnd,
      this.address,
      this.description,
      this.pdfurl,
      this.entryurl,
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
      image,
      price,
      dateStart,
      dateEnd,
      address,
      description,
      pdfurl,
      entryurl,
      direction,
      const DeepCollectionEquality().hash(_persons));

  @override
  String toString() {
    return 'Festival(id: $id, title: $title, image: $image, price: $price, dateStart: $dateStart, dateEnd: $dateEnd, address: $address, description: $description, pdfurl: $pdfurl, entryurl: $entryurl, direction: $direction, persons: $persons)';
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
      ImageData? image,
      int price,
      @JsonKey(name: "date_start") DateTime? dateStart,
      @JsonKey(name: "date_end") DateTime? dateEnd,
      String? address,
      String? description,
      String? pdfurl,
      String? entryurl,
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
    Object? image = freezed,
    Object? price = null,
    Object? dateStart = freezed,
    Object? dateEnd = freezed,
    Object? address = freezed,
    Object? description = freezed,
    Object? pdfurl = freezed,
    Object? entryurl = freezed,
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
