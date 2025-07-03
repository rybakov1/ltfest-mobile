// lib/models/laboratory_day.dart
import 'package:freezed_annotation/freezed_annotation.dart';

import 'laboratory_day_event.dart';

part 'laboratory_day.freezed.dart';
part 'laboratory_day.g.dart';

@freezed
abstract class LaboratoryDay with _$LaboratoryDay {
  const factory LaboratoryDay({
    int? id,
    @JsonKey(name: 'laboratory_id') int? laboratoryId,
    @JsonKey(name: 'day_number') int? dayNumber,
    DateTime? date,
    List<LaboratoryDayEvent>? events,
  }) = _LaboratoryDay;

  factory LaboratoryDay.fromJson(Map<String, dynamic> json) => _$LaboratoryDayFromJson(json);
}