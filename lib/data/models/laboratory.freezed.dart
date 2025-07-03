// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laboratory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Laboratory {
  int get id;
  String get title;
  String? get image;
  String? get description;
  String? get address;
  Direction get direction;
  List<Teacher>? get teachers;
  @JsonKey(name: 'learning_types')
  List<LearningType>? get learningTypes;
  List<LaboratoryDay>? get days;

  /// Create a copy of Laboratory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LaboratoryCopyWith<Laboratory> get copyWith =>
      _$LaboratoryCopyWithImpl<Laboratory>(this as Laboratory, _$identity);

  /// Serializes this Laboratory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Laboratory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            const DeepCollectionEquality().equals(other.teachers, teachers) &&
            const DeepCollectionEquality()
                .equals(other.learningTypes, learningTypes) &&
            const DeepCollectionEquality().equals(other.days, days));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      image,
      description,
      address,
      direction,
      const DeepCollectionEquality().hash(teachers),
      const DeepCollectionEquality().hash(learningTypes),
      const DeepCollectionEquality().hash(days));

  @override
  String toString() {
    return 'Laboratory(id: $id, title: $title, image: $image, description: $description, address: $address, direction: $direction, teachers: $teachers, learningTypes: $learningTypes, days: $days)';
  }
}

/// @nodoc
abstract mixin class $LaboratoryCopyWith<$Res> {
  factory $LaboratoryCopyWith(
          Laboratory value, $Res Function(Laboratory) _then) =
      _$LaboratoryCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String? image,
      String? description,
      String? address,
      Direction direction,
      List<Teacher>? teachers,
      @JsonKey(name: 'learning_types') List<LearningType>? learningTypes,
      List<LaboratoryDay>? days});

  $DirectionCopyWith<$Res> get direction;
}

/// @nodoc
class _$LaboratoryCopyWithImpl<$Res> implements $LaboratoryCopyWith<$Res> {
  _$LaboratoryCopyWithImpl(this._self, this._then);

  final Laboratory _self;
  final $Res Function(Laboratory) _then;

  /// Create a copy of Laboratory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? direction = null,
    Object? teachers = freezed,
    Object? learningTypes = freezed,
    Object? days = freezed,
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
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      teachers: freezed == teachers
          ? _self.teachers
          : teachers // ignore: cast_nullable_to_non_nullable
              as List<Teacher>?,
      learningTypes: freezed == learningTypes
          ? _self.learningTypes
          : learningTypes // ignore: cast_nullable_to_non_nullable
              as List<LearningType>?,
      days: freezed == days
          ? _self.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<LaboratoryDay>?,
    ));
  }

  /// Create a copy of Laboratory
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
class _Laboratory implements Laboratory {
  const _Laboratory(
      {required this.id,
      required this.title,
      this.image,
      this.description,
      this.address,
      required this.direction,
      final List<Teacher>? teachers,
      @JsonKey(name: 'learning_types') final List<LearningType>? learningTypes,
      final List<LaboratoryDay>? days})
      : _teachers = teachers,
        _learningTypes = learningTypes,
        _days = days;
  factory _Laboratory.fromJson(Map<String, dynamic> json) =>
      _$LaboratoryFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? image;
  @override
  final String? description;
  @override
  final String? address;
  @override
  final Direction direction;
  final List<Teacher>? _teachers;
  @override
  List<Teacher>? get teachers {
    final value = _teachers;
    if (value == null) return null;
    if (_teachers is EqualUnmodifiableListView) return _teachers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<LearningType>? _learningTypes;
  @override
  @JsonKey(name: 'learning_types')
  List<LearningType>? get learningTypes {
    final value = _learningTypes;
    if (value == null) return null;
    if (_learningTypes is EqualUnmodifiableListView) return _learningTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<LaboratoryDay>? _days;
  @override
  List<LaboratoryDay>? get days {
    final value = _days;
    if (value == null) return null;
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Laboratory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LaboratoryCopyWith<_Laboratory> get copyWith =>
      __$LaboratoryCopyWithImpl<_Laboratory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LaboratoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Laboratory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            const DeepCollectionEquality().equals(other._teachers, _teachers) &&
            const DeepCollectionEquality()
                .equals(other._learningTypes, _learningTypes) &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      image,
      description,
      address,
      direction,
      const DeepCollectionEquality().hash(_teachers),
      const DeepCollectionEquality().hash(_learningTypes),
      const DeepCollectionEquality().hash(_days));

  @override
  String toString() {
    return 'Laboratory(id: $id, title: $title, image: $image, description: $description, address: $address, direction: $direction, teachers: $teachers, learningTypes: $learningTypes, days: $days)';
  }
}

/// @nodoc
abstract mixin class _$LaboratoryCopyWith<$Res>
    implements $LaboratoryCopyWith<$Res> {
  factory _$LaboratoryCopyWith(
          _Laboratory value, $Res Function(_Laboratory) _then) =
      __$LaboratoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? image,
      String? description,
      String? address,
      Direction direction,
      List<Teacher>? teachers,
      @JsonKey(name: 'learning_types') List<LearningType>? learningTypes,
      List<LaboratoryDay>? days});

  @override
  $DirectionCopyWith<$Res> get direction;
}

/// @nodoc
class __$LaboratoryCopyWithImpl<$Res> implements _$LaboratoryCopyWith<$Res> {
  __$LaboratoryCopyWithImpl(this._self, this._then);

  final _Laboratory _self;
  final $Res Function(_Laboratory) _then;

  /// Create a copy of Laboratory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? image = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? direction = null,
    Object? teachers = freezed,
    Object? learningTypes = freezed,
    Object? days = freezed,
  }) {
    return _then(_Laboratory(
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
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      teachers: freezed == teachers
          ? _self._teachers
          : teachers // ignore: cast_nullable_to_non_nullable
              as List<Teacher>?,
      learningTypes: freezed == learningTypes
          ? _self._learningTypes
          : learningTypes // ignore: cast_nullable_to_non_nullable
              as List<LearningType>?,
      days: freezed == days
          ? _self._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<LaboratoryDay>?,
    ));
  }

  /// Create a copy of Laboratory
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
