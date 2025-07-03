// lib/models/laboratory_day_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'laboratory_day_event.freezed.dart';
part 'laboratory_day_event.g.dart';

@freezed
abstract class LaboratoryDayEvent with _$LaboratoryDayEvent {
  const factory LaboratoryDayEvent({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'day_id') int? dayId,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'event_time') String? eventTime,
    @JsonKey(name: 'description') String? description,
  }) = _LaboratoryDayEvent;

  factory LaboratoryDayEvent.fromJson(Map<String, dynamic> json) => _$LaboratoryDayEventFromJson(json);
}