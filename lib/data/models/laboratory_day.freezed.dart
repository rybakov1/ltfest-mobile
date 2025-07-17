// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laboratory_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LaboratoryDay {
  int? get id;
  @JsonKey(name: 'day_number')
  int? get dayNumber;
  DateTime? get date;
  @JsonKey(name: 'laboratory_day_events')
  List<LaboratoryDayEvent>? get events;

  /// Create a copy of LaboratoryDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LaboratoryDayCopyWith<LaboratoryDay> get copyWith =>
      _$LaboratoryDayCopyWithImpl<LaboratoryDay>(
          this as LaboratoryDay, _$identity);

  /// Serializes this LaboratoryDay to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LaboratoryDay &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other.events, events));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, dayNumber, date,
      const DeepCollectionEquality().hash(events));

  @override
  String toString() {
    return 'LaboratoryDay(id: $id, dayNumber: $dayNumber, date: $date, events: $events)';
  }
}

/// @nodoc
abstract mixin class $LaboratoryDayCopyWith<$Res> {
  factory $LaboratoryDayCopyWith(
          LaboratoryDay value, $Res Function(LaboratoryDay) _then) =
      _$LaboratoryDayCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'day_number') int? dayNumber,
      DateTime? date,
      @JsonKey(name: 'laboratory_day_events')
      List<LaboratoryDayEvent>? events});
}

/// @nodoc
class _$LaboratoryDayCopyWithImpl<$Res>
    implements $LaboratoryDayCopyWith<$Res> {
  _$LaboratoryDayCopyWithImpl(this._self, this._then);

  final LaboratoryDay _self;
  final $Res Function(LaboratoryDay) _then;

  /// Create a copy of LaboratoryDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? dayNumber = freezed,
    Object? date = freezed,
    Object? events = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      dayNumber: freezed == dayNumber
          ? _self.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      events: freezed == events
          ? _self.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<LaboratoryDayEvent>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LaboratoryDay implements LaboratoryDay {
  const _LaboratoryDay(
      {this.id,
      @JsonKey(name: 'day_number') this.dayNumber,
      this.date,
      @JsonKey(name: 'laboratory_day_events')
      final List<LaboratoryDayEvent>? events})
      : _events = events;
  factory _LaboratoryDay.fromJson(Map<String, dynamic> json) =>
      _$LaboratoryDayFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'day_number')
  final int? dayNumber;
  @override
  final DateTime? date;
  final List<LaboratoryDayEvent>? _events;
  @override
  @JsonKey(name: 'laboratory_day_events')
  List<LaboratoryDayEvent>? get events {
    final value = _events;
    if (value == null) return null;
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of LaboratoryDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LaboratoryDayCopyWith<_LaboratoryDay> get copyWith =>
      __$LaboratoryDayCopyWithImpl<_LaboratoryDay>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LaboratoryDayToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LaboratoryDay &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, dayNumber, date,
      const DeepCollectionEquality().hash(_events));

  @override
  String toString() {
    return 'LaboratoryDay(id: $id, dayNumber: $dayNumber, date: $date, events: $events)';
  }
}

/// @nodoc
abstract mixin class _$LaboratoryDayCopyWith<$Res>
    implements $LaboratoryDayCopyWith<$Res> {
  factory _$LaboratoryDayCopyWith(
          _LaboratoryDay value, $Res Function(_LaboratoryDay) _then) =
      __$LaboratoryDayCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'day_number') int? dayNumber,
      DateTime? date,
      @JsonKey(name: 'laboratory_day_events')
      List<LaboratoryDayEvent>? events});
}

/// @nodoc
class __$LaboratoryDayCopyWithImpl<$Res>
    implements _$LaboratoryDayCopyWith<$Res> {
  __$LaboratoryDayCopyWithImpl(this._self, this._then);

  final _LaboratoryDay _self;
  final $Res Function(_LaboratoryDay) _then;

  /// Create a copy of LaboratoryDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? dayNumber = freezed,
    Object? date = freezed,
    Object? events = freezed,
  }) {
    return _then(_LaboratoryDay(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      dayNumber: freezed == dayNumber
          ? _self.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      events: freezed == events
          ? _self._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<LaboratoryDayEvent>?,
    ));
  }
}

// dart format on
