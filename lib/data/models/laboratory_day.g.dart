// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laboratory_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LaboratoryDay _$LaboratoryDayFromJson(Map<String, dynamic> json) =>
    _LaboratoryDay(
      id: (json['id'] as num?)?.toInt(),
      dayNumber: (json['day_number'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      events: (json['laboratory_day_events'] as List<dynamic>?)
          ?.map((e) => LaboratoryDayEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LaboratoryDayToJson(_LaboratoryDay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day_number': instance.dayNumber,
      'date': instance.date?.toIso8601String(),
      'laboratory_day_events': instance.events,
    };
