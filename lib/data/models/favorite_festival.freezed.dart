// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_festival.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteFestival {
  int get id;
  String get title;
  String? get address;
  int get price;
  @JsonKey(name: 'date_start')
  DateTime? get dateStart;
  @JsonKey(name: 'date_end')
  DateTime? get dateEnd;
  String? get description;
  String? get pdfurl;
  String? get entryurl;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime get publishedAt;

  /// Create a copy of FavoriteFestival
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FavoriteFestivalCopyWith<FavoriteFestival> get copyWith =>
      _$FavoriteFestivalCopyWithImpl<FavoriteFestival>(
          this as FavoriteFestival, _$identity);

  /// Serializes this FavoriteFestival to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FavoriteFestival &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.dateStart, dateStart) ||
                other.dateStart == dateStart) &&
            (identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pdfurl, pdfurl) || other.pdfurl == pdfurl) &&
            (identical(other.entryurl, entryurl) ||
                other.entryurl == entryurl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      address,
      price,
      dateStart,
      dateEnd,
      description,
      pdfurl,
      entryurl,
      createdAt,
      updatedAt,
      publishedAt);

  @override
  String toString() {
    return 'FavoriteFestival(id: $id, title: $title, address: $address, price: $price, dateStart: $dateStart, dateEnd: $dateEnd, description: $description, pdfurl: $pdfurl, entryurl: $entryurl, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt)';
  }
}

/// @nodoc
abstract mixin class $FavoriteFestivalCopyWith<$Res> {
  factory $FavoriteFestivalCopyWith(
          FavoriteFestival value, $Res Function(FavoriteFestival) _then) =
      _$FavoriteFestivalCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String? address,
      int price,
      @JsonKey(name: 'date_start') DateTime? dateStart,
      @JsonKey(name: 'date_end') DateTime? dateEnd,
      String? description,
      String? pdfurl,
      String? entryurl,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime publishedAt});
}

/// @nodoc
class _$FavoriteFestivalCopyWithImpl<$Res>
    implements $FavoriteFestivalCopyWith<$Res> {
  _$FavoriteFestivalCopyWithImpl(this._self, this._then);

  final FavoriteFestival _self;
  final $Res Function(FavoriteFestival) _then;

  /// Create a copy of FavoriteFestival
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? address = freezed,
    Object? price = null,
    Object? dateStart = freezed,
    Object? dateEnd = freezed,
    Object? description = freezed,
    Object? pdfurl = freezed,
    Object? entryurl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishedAt = null,
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
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
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
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedAt: null == publishedAt
          ? _self.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _FavoriteFestival implements FavoriteFestival {
  const _FavoriteFestival(
      {required this.id,
      required this.title,
      this.address,
      required this.price,
      @JsonKey(name: 'date_start') this.dateStart,
      @JsonKey(name: 'date_end') this.dateEnd,
      this.description,
      this.pdfurl,
      this.entryurl,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt});
  factory _FavoriteFestival.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFestivalFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? address;
  @override
  final int price;
  @override
  @JsonKey(name: 'date_start')
  final DateTime? dateStart;
  @override
  @JsonKey(name: 'date_end')
  final DateTime? dateEnd;
  @override
  final String? description;
  @override
  final String? pdfurl;
  @override
  final String? entryurl;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime publishedAt;

  /// Create a copy of FavoriteFestival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FavoriteFestivalCopyWith<_FavoriteFestival> get copyWith =>
      __$FavoriteFestivalCopyWithImpl<_FavoriteFestival>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FavoriteFestivalToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FavoriteFestival &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.dateStart, dateStart) ||
                other.dateStart == dateStart) &&
            (identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pdfurl, pdfurl) || other.pdfurl == pdfurl) &&
            (identical(other.entryurl, entryurl) ||
                other.entryurl == entryurl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      address,
      price,
      dateStart,
      dateEnd,
      description,
      pdfurl,
      entryurl,
      createdAt,
      updatedAt,
      publishedAt);

  @override
  String toString() {
    return 'FavoriteFestival(id: $id, title: $title, address: $address, price: $price, dateStart: $dateStart, dateEnd: $dateEnd, description: $description, pdfurl: $pdfurl, entryurl: $entryurl, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt)';
  }
}

/// @nodoc
abstract mixin class _$FavoriteFestivalCopyWith<$Res>
    implements $FavoriteFestivalCopyWith<$Res> {
  factory _$FavoriteFestivalCopyWith(
          _FavoriteFestival value, $Res Function(_FavoriteFestival) _then) =
      __$FavoriteFestivalCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? address,
      int price,
      @JsonKey(name: 'date_start') DateTime? dateStart,
      @JsonKey(name: 'date_end') DateTime? dateEnd,
      String? description,
      String? pdfurl,
      String? entryurl,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime publishedAt});
}

/// @nodoc
class __$FavoriteFestivalCopyWithImpl<$Res>
    implements _$FavoriteFestivalCopyWith<$Res> {
  __$FavoriteFestivalCopyWithImpl(this._self, this._then);

  final _FavoriteFestival _self;
  final $Res Function(_FavoriteFestival) _then;

  /// Create a copy of FavoriteFestival
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? address = freezed,
    Object? price = null,
    Object? dateStart = freezed,
    Object? dateEnd = freezed,
    Object? description = freezed,
    Object? pdfurl = freezed,
    Object? entryurl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishedAt = null,
  }) {
    return _then(_FavoriteFestival(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
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
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedAt: null == publishedAt
          ? _self.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
