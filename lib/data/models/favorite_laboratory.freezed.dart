// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_laboratory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteLaboratory {
  int get id;
  String get title;
  String? get description;
  String? get address;
  String? get url;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime get publishedAt;

  /// Create a copy of FavoriteLaboratory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FavoriteLaboratoryCopyWith<FavoriteLaboratory> get copyWith =>
      _$FavoriteLaboratoryCopyWithImpl<FavoriteLaboratory>(
          this as FavoriteLaboratory, _$identity);

  /// Serializes this FavoriteLaboratory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FavoriteLaboratory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, address,
      url, createdAt, updatedAt, publishedAt);

  @override
  String toString() {
    return 'FavoriteLaboratory(id: $id, title: $title, description: $description, address: $address, url: $url, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt)';
  }
}

/// @nodoc
abstract mixin class $FavoriteLaboratoryCopyWith<$Res> {
  factory $FavoriteLaboratoryCopyWith(
          FavoriteLaboratory value, $Res Function(FavoriteLaboratory) _then) =
      _$FavoriteLaboratoryCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      String? address,
      String? url,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime publishedAt});
}

/// @nodoc
class _$FavoriteLaboratoryCopyWithImpl<$Res>
    implements $FavoriteLaboratoryCopyWith<$Res> {
  _$FavoriteLaboratoryCopyWithImpl(this._self, this._then);

  final FavoriteLaboratory _self;
  final $Res Function(FavoriteLaboratory) _then;

  /// Create a copy of FavoriteLaboratory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? address = freezed,
    Object? url = freezed,
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
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
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
class _FavoriteLaboratory implements FavoriteLaboratory {
  const _FavoriteLaboratory(
      {required this.id,
      required this.title,
      this.description,
      this.address,
      this.url,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt});
  factory _FavoriteLaboratory.fromJson(Map<String, dynamic> json) =>
      _$FavoriteLaboratoryFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? address;
  @override
  final String? url;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime publishedAt;

  /// Create a copy of FavoriteLaboratory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FavoriteLaboratoryCopyWith<_FavoriteLaboratory> get copyWith =>
      __$FavoriteLaboratoryCopyWithImpl<_FavoriteLaboratory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FavoriteLaboratoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FavoriteLaboratory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, address,
      url, createdAt, updatedAt, publishedAt);

  @override
  String toString() {
    return 'FavoriteLaboratory(id: $id, title: $title, description: $description, address: $address, url: $url, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt)';
  }
}

/// @nodoc
abstract mixin class _$FavoriteLaboratoryCopyWith<$Res>
    implements $FavoriteLaboratoryCopyWith<$Res> {
  factory _$FavoriteLaboratoryCopyWith(
          _FavoriteLaboratory value, $Res Function(_FavoriteLaboratory) _then) =
      __$FavoriteLaboratoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? description,
      String? address,
      String? url,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime publishedAt});
}

/// @nodoc
class __$FavoriteLaboratoryCopyWithImpl<$Res>
    implements _$FavoriteLaboratoryCopyWith<$Res> {
  __$FavoriteLaboratoryCopyWithImpl(this._self, this._then);

  final _FavoriteLaboratory _self;
  final $Res Function(_FavoriteLaboratory) _then;

  /// Create a copy of FavoriteLaboratory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? address = freezed,
    Object? url = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishedAt = null,
  }) {
    return _then(_FavoriteLaboratory(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
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
