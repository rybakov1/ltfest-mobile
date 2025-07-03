// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jury.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Jury {
  int get id;
  String get firstname;
  String get lastname;
  String? get image;
  String? get description;

  /// Create a copy of Jury
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JuryCopyWith<Jury> get copyWith =>
      _$JuryCopyWithImpl<Jury>(this as Jury, _$identity);

  /// Serializes this Jury to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Jury &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, firstname, lastname, image, description);

  @override
  String toString() {
    return 'Jury(id: $id, firstname: $firstname, lastname: $lastname, image: $image, description: $description)';
  }
}

/// @nodoc
abstract mixin class $JuryCopyWith<$Res> {
  factory $JuryCopyWith(Jury value, $Res Function(Jury) _then) =
      _$JuryCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String firstname,
      String lastname,
      String? image,
      String? description});
}

/// @nodoc
class _$JuryCopyWithImpl<$Res> implements $JuryCopyWith<$Res> {
  _$JuryCopyWithImpl(this._self, this._then);

  final Jury _self;
  final $Res Function(Jury) _then;

  /// Create a copy of Jury
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? image = freezed,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstname: null == firstname
          ? _self.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _self.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Jury implements Jury {
  const _Jury(
      {required this.id,
      required this.firstname,
      required this.lastname,
      this.image,
      this.description});
  factory _Jury.fromJson(Map<String, dynamic> json) => _$JuryFromJson(json);

  @override
  final int id;
  @override
  final String firstname;
  @override
  final String lastname;
  @override
  final String? image;
  @override
  final String? description;

  /// Create a copy of Jury
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JuryCopyWith<_Jury> get copyWith =>
      __$JuryCopyWithImpl<_Jury>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JuryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Jury &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, firstname, lastname, image, description);

  @override
  String toString() {
    return 'Jury(id: $id, firstname: $firstname, lastname: $lastname, image: $image, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$JuryCopyWith<$Res> implements $JuryCopyWith<$Res> {
  factory _$JuryCopyWith(_Jury value, $Res Function(_Jury) _then) =
      __$JuryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String firstname,
      String lastname,
      String? image,
      String? description});
}

/// @nodoc
class __$JuryCopyWithImpl<$Res> implements _$JuryCopyWith<$Res> {
  __$JuryCopyWithImpl(this._self, this._then);

  final _Jury _self;
  final $Res Function(_Jury) _then;

  /// Create a copy of Jury
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? image = freezed,
    Object? description = freezed,
  }) {
    return _then(_Jury(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstname: null == firstname
          ? _self.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _self.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
