// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory_day_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LaboratoryDayEvent _$LaboratoryDayEventFromJson(Map<String, dynamic> json) =>
    _LaboratoryDayEvent(
      id: (json['id'] as num?)?.toInt(),
      dayId: (json['day_id'] as num?)?.toInt(),
      title: json['title'] as String,
      eventTime: json['event_time'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$LaboratoryDayEventToJson(_LaboratoryDayEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day_id': instance.dayId,
      'title': instance.title,
      'event_time': instance.eventTime,
      'description': instance.description,
    };
