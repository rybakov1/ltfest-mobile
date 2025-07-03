import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/teacher.dart';

import 'direction.dart';
import 'laboratory_day.dart';
import 'laboratory_learning_type.dart';

part 'laboratory.freezed.dart';
part 'laboratory.g.dart';

@freezed
abstract class Laboratory with _$Laboratory {
  const factory Laboratory({
    required int id,
    required String title,
    String? image,
    String? description,
    String? address,
    required Direction direction,
    List<Teacher>? teachers,
    @JsonKey(name: 'learning_types') List<LearningType>? learningTypes,
    List<LaboratoryDay>? days,
  }) = _Laboratory;

  factory Laboratory.fromJson(Map<String, dynamic> json) =>
      _$LaboratoryFromJson(json);
}
