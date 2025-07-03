import 'package:freezed_annotation/freezed_annotation.dart';

import 'direction.dart';

part 'upcoming_events.freezed.dart';
part 'upcoming_events.g.dart';

enum EventType {
  @JsonValue('festival')
  festival,
  @JsonValue('laboratory')
  laboratory,
}

@freezed
abstract class UpcomingEvent with _$UpcomingEvent {
  const factory UpcomingEvent({
    required int id,
    required String title,
    required EventType type,
    required String date,
    String? image,
    String? description,
    String? address,
    required Direction direction,
  }) = _UpcomingEvent;

  factory UpcomingEvent.fromJson(Map<String, dynamic> json) => _$UpcomingEventFromJson(json);
}