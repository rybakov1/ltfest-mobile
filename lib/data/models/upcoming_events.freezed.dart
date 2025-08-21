// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upcoming_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpcomingEvent {
  int get id;
  String get title;
  EventType get type;
  String get date;
  String? get image;
  String? get description;
  String? get address;
  Direction get direction;

  /// Create a copy of UpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpcomingEventCopyWith<UpcomingEvent> get copyWith =>
      _$UpcomingEventCopyWithImpl<UpcomingEvent>(
          this as UpcomingEvent, _$identity);

  /// Serializes this UpcomingEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpcomingEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, type, date, image,
      description, address, direction);

  @override
  String toString() {
    return 'UpcomingEvent(id: $id, title: $title, type: $type, date: $date, image: $image, description: $description, address: $address, direction: $direction)';
  }
}

/// @nodoc
abstract mixin class $UpcomingEventCopyWith<$Res> {
  factory $UpcomingEventCopyWith(
          UpcomingEvent value, $Res Function(UpcomingEvent) _then) =
      _$UpcomingEventCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      EventType type,
      String date,
      String? image,
      String? description,
      String? address,
      Direction direction});

  $DirectionCopyWith<$Res> get direction;
}

/// @nodoc
class _$UpcomingEventCopyWithImpl<$Res>
    implements $UpcomingEventCopyWith<$Res> {
  _$UpcomingEventCopyWithImpl(this._self, this._then);

  final UpcomingEvent _self;
  final $Res Function(UpcomingEvent) _then;

  /// Create a copy of UpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? date = null,
    Object? image = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? direction = null,
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
              as EventType,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
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
    ));
  }

  /// Create a copy of UpcomingEvent
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
class _UpcomingEvent extends UpcomingEvent {
  const _UpcomingEvent(
      {required this.id,
      required this.title,
      required this.type,
      required this.date,
      this.image,
      this.description,
      this.address,
      required this.direction})
      : super._();
  factory _UpcomingEvent.fromJson(Map<String, dynamic> json) =>
      _$UpcomingEventFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final EventType type;
  @override
  final String date;
  @override
  final String? image;
  @override
  final String? description;
  @override
  final String? address;
  @override
  final Direction direction;

  /// Create a copy of UpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpcomingEventCopyWith<_UpcomingEvent> get copyWith =>
      __$UpcomingEventCopyWithImpl<_UpcomingEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpcomingEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpcomingEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, type, date, image,
      description, address, direction);

  @override
  String toString() {
    return 'UpcomingEvent(id: $id, title: $title, type: $type, date: $date, image: $image, description: $description, address: $address, direction: $direction)';
  }

  @override
  int get favoriteId => id;

  @override
  EventType get favoriteType => type;
}

/// @nodoc
abstract mixin class _$UpcomingEventCopyWith<$Res>
    implements $UpcomingEventCopyWith<$Res> {
  factory _$UpcomingEventCopyWith(
          _UpcomingEvent value, $Res Function(_UpcomingEvent) _then) =
      __$UpcomingEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      EventType type,
      String date,
      String? image,
      String? description,
      String? address,
      Direction direction});

  @override
  $DirectionCopyWith<$Res> get direction;
}

/// @nodoc
class __$UpcomingEventCopyWithImpl<$Res>
    implements _$UpcomingEventCopyWith<$Res> {
  __$UpcomingEventCopyWithImpl(this._self, this._then);

  final _UpcomingEvent _self;
  final $Res Function(_UpcomingEvent) _then;

  /// Create a copy of UpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? date = null,
    Object? image = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? direction = null,
  }) {
    return _then(_UpcomingEvent(
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
              as EventType,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
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
    ));
  }

  /// Create a copy of UpcomingEvent
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
