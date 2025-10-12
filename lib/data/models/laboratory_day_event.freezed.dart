// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laboratory_day_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LaboratoryDayEvent {
  @JsonKey(name: 'id')
  int? get id;
  @JsonKey(name: 'day_id')
  int? get dayId;
  @JsonKey(name: 'title')
  String get title;
  @JsonKey(name: 'event_time')
  String? get eventTime;
  @JsonKey(name: 'description')
  String? get description;

  /// Create a copy of LaboratoryDayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LaboratoryDayEventCopyWith<LaboratoryDayEvent> get copyWith =>
      _$LaboratoryDayEventCopyWithImpl<LaboratoryDayEvent>(
          this as LaboratoryDayEvent, _$identity);

  /// Serializes this LaboratoryDayEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LaboratoryDayEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayId, dayId) || other.dayId == dayId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.eventTime, eventTime) ||
                other.eventTime == eventTime) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, dayId, title, eventTime, description);

  @override
  String toString() {
    return 'LaboratoryDayEvent(id: $id, dayId: $dayId, title: $title, eventTime: $eventTime, description: $description)';
  }
}

/// @nodoc
abstract mixin class $LaboratoryDayEventCopyWith<$Res> {
  factory $LaboratoryDayEventCopyWith(
          LaboratoryDayEvent value, $Res Function(LaboratoryDayEvent) _then) =
      _$LaboratoryDayEventCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'day_id') int? dayId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'event_time') String? eventTime,
      @JsonKey(name: 'description') String? description});
}

/// @nodoc
class _$LaboratoryDayEventCopyWithImpl<$Res>
    implements $LaboratoryDayEventCopyWith<$Res> {
  _$LaboratoryDayEventCopyWithImpl(this._self, this._then);

  final LaboratoryDayEvent _self;
  final $Res Function(LaboratoryDayEvent) _then;

  /// Create a copy of LaboratoryDayEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? dayId = freezed,
    Object? title = null,
    Object? eventTime = freezed,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      dayId: freezed == dayId
          ? _self.dayId
          : dayId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      eventTime: freezed == eventTime
          ? _self.eventTime
          : eventTime // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LaboratoryDayEvent].
extension LaboratoryDayEventPatterns on LaboratoryDayEvent {
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
    TResult Function(_LaboratoryDayEvent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LaboratoryDayEvent() when $default != null:
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
    TResult Function(_LaboratoryDayEvent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LaboratoryDayEvent():
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
    TResult? Function(_LaboratoryDayEvent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LaboratoryDayEvent() when $default != null:
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
            @JsonKey(name: 'id') int? id,
            @JsonKey(name: 'day_id') int? dayId,
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'event_time') String? eventTime,
            @JsonKey(name: 'description') String? description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LaboratoryDayEvent() when $default != null:
        return $default(_that.id, _that.dayId, _that.title, _that.eventTime,
            _that.description);
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
            @JsonKey(name: 'id') int? id,
            @JsonKey(name: 'day_id') int? dayId,
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'event_time') String? eventTime,
            @JsonKey(name: 'description') String? description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LaboratoryDayEvent():
        return $default(_that.id, _that.dayId, _that.title, _that.eventTime,
            _that.description);
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
            @JsonKey(name: 'id') int? id,
            @JsonKey(name: 'day_id') int? dayId,
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'event_time') String? eventTime,
            @JsonKey(name: 'description') String? description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LaboratoryDayEvent() when $default != null:
        return $default(_that.id, _that.dayId, _that.title, _that.eventTime,
            _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LaboratoryDayEvent implements LaboratoryDayEvent {
  const _LaboratoryDayEvent(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'day_id') this.dayId,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'event_time') this.eventTime,
      @JsonKey(name: 'description') this.description});
  factory _LaboratoryDayEvent.fromJson(Map<String, dynamic> json) =>
      _$LaboratoryDayEventFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'day_id')
  final int? dayId;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'event_time')
  final String? eventTime;
  @override
  @JsonKey(name: 'description')
  final String? description;

  /// Create a copy of LaboratoryDayEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LaboratoryDayEventCopyWith<_LaboratoryDayEvent> get copyWith =>
      __$LaboratoryDayEventCopyWithImpl<_LaboratoryDayEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LaboratoryDayEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LaboratoryDayEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayId, dayId) || other.dayId == dayId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.eventTime, eventTime) ||
                other.eventTime == eventTime) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, dayId, title, eventTime, description);

  @override
  String toString() {
    return 'LaboratoryDayEvent(id: $id, dayId: $dayId, title: $title, eventTime: $eventTime, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$LaboratoryDayEventCopyWith<$Res>
    implements $LaboratoryDayEventCopyWith<$Res> {
  factory _$LaboratoryDayEventCopyWith(
          _LaboratoryDayEvent value, $Res Function(_LaboratoryDayEvent) _then) =
      __$LaboratoryDayEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'day_id') int? dayId,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'event_time') String? eventTime,
      @JsonKey(name: 'description') String? description});
}

/// @nodoc
class __$LaboratoryDayEventCopyWithImpl<$Res>
    implements _$LaboratoryDayEventCopyWith<$Res> {
  __$LaboratoryDayEventCopyWithImpl(this._self, this._then);

  final _LaboratoryDayEvent _self;
  final $Res Function(_LaboratoryDayEvent) _then;

  /// Create a copy of LaboratoryDayEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? dayId = freezed,
    Object? title = null,
    Object? eventTime = freezed,
    Object? description = freezed,
  }) {
    return _then(_LaboratoryDayEvent(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      dayId: freezed == dayId
          ? _self.dayId
          : dayId // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      eventTime: freezed == eventTime
          ? _self.eventTime
          : eventTime // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
