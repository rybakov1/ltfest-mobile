// lib/models/jury.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'age_category.freezed.dart';
part 'age_category.g.dart';

@freezed
abstract class AgeCategory with _$AgeCategory {
  const factory AgeCategory({
    required int id,
    required String title,
  }) = _AgeCategory;

  factory AgeCategory.fromJson(Map<String, dynamic> json) =>
      _$AgeCategoryFromJson(json);
}
