// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpcomingEvent _$UpcomingEventFromJson(Map<String, dynamic> json) =>
    _UpcomingEvent(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      date: json['date'] as String,
      image: json['image'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      direction: Direction.fromJson(json['direction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpcomingEventToJson(_UpcomingEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$EventTypeEnumMap[instance.type]!,
      'date': instance.date,
      'image': instance.image,
      'description': instance.description,
      'address': instance.address,
      'direction': instance.direction,
    };

const _$EventTypeEnumMap = {
  EventType.festival: 'festival',
  EventType.laboratory: 'laboratory',
};
