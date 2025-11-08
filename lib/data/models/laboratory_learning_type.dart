import 'package:freezed_annotation/freezed_annotation.dart';

part 'laboratory_learning_type.freezed.dart';
part 'laboratory_learning_type.g.dart';

@freezed
abstract class LearningType with _$LearningType {
  const factory LearningType({
    required int id,
    required String type,
    required int price,
    @JsonKey(name: 'date_info') String? dateInfo,
    String? location,
    String? duration,
    String? certificate,
  }) = _LearningType;

  factory LearningType.fromJson(Map<String, dynamic> json) => _$LearningTypeFromJson(json);
}