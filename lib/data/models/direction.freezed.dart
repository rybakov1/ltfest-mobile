// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Direction {
  int get id;
  String get title;

  /// Create a copy of Direction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<Direction> get copyWith =>
      _$DirectionCopyWithImpl<Direction>(this as Direction, _$identity);

  /// Serializes this Direction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Direction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @override
  String toString() {
    return 'Direction(id: $id, title: $title)';
  }
}

/// @nodoc
abstract mixin class $DirectionCopyWith<$Res> {
  factory $DirectionCopyWith(Direction value, $Res Function(Direction) _then) =
      _$DirectionCopyWithImpl;
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class _$DirectionCopyWithImpl<$Res> implements $DirectionCopyWith<$Res> {
  _$DirectionCopyWithImpl(this._self, this._then);

  final Direction _self;
  final $Res Function(Direction) _then;

  /// Create a copy of Direction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Direction implements Direction {
  const _Direction({required this.id, required this.title});
  factory _Direction.fromJson(Map<String, dynamic> json) =>
      _$DirectionFromJson(json);

  @override
  final int id;
  @override
  final String title;

  /// Create a copy of Direction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectionCopyWith<_Direction> get copyWith =>
      __$DirectionCopyWithImpl<_Direction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DirectionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Direction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @override
  String toString() {
    return 'Direction(id: $id, title: $title)';
  }
}

/// @nodoc
abstract mixin class _$DirectionCopyWith<$Res>
    implements $DirectionCopyWith<$Res> {
  factory _$DirectionCopyWith(
          _Direction value, $Res Function(_Direction) _then) =
      __$DirectionCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class __$DirectionCopyWithImpl<$Res> implements _$DirectionCopyWith<$Res> {
  __$DirectionCopyWithImpl(this._self, this._then);

  final _Direction _self;
  final $Res Function(_Direction) _then;

  /// Create a copy of Direction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_Direction(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
