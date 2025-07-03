// lib/models/jury.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';

part 'activity.g.dart';

@freezed
abstract class Activity with _$Activity {
  const factory Activity({
    required int id,
    required String title,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
