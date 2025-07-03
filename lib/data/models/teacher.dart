// lib/models/jury.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'teacher.freezed.dart';

part 'teacher.g.dart';

@freezed
abstract class Teacher with _$Teacher {
  const factory Teacher({
    required int id,
    required String firstname,
    required String lastname,
    String? image,
    String? description,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);
}
