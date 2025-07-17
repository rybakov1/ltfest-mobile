import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/person.dart';

import 'direction.dart';
import 'image_data.dart';
import 'laboratory_day.dart';
import 'laboratory_learning_type.dart';

part 'laboratory.freezed.dart';
part 'laboratory.g.dart';

@freezed
abstract class Laboratory with _$Laboratory {
  const factory Laboratory({
    required int id,
    required String title,
    ImageData? image,
    String? description,
    String? address,
    required Direction direction,
    List<Person>? persons,
    @JsonKey(name: 'learning_types') List<LearningType>? learningTypes,
    List<LaboratoryDay>? days,
  }) = _Laboratory;

  factory Laboratory.fromJson(Map<String, dynamic> json) =>
      _$LaboratoryFromJson(json);
}