// lib/models/laboratory_learning_type.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'laboratory_learning_type.freezed.dart';
part 'laboratory_learning_type.g.dart';

@freezed
abstract class LearningType with _$LearningType {
  const factory LearningType({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'laboratory_id') required int laboratoryId,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'price') required int price,
    @JsonKey(name: 'date_info') String? dateInfo,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'duration') String? duration,
    @JsonKey(name: 'certificate') String? certificate,
  }) = _LearningType;

  factory LearningType.fromJson(Map<String, dynamic> json) => _$LearningTypeFromJson(json);
}