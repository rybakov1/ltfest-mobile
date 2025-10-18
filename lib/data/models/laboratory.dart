import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/person.dart';

import 'direction.dart';
import 'image_data.dart';
import 'laboratory_day.dart';
import 'laboratory_learning_type.dart';

part 'laboratory.freezed.dart';
part 'laboratory.g.dart';

@freezed
abstract class Laboratory with _$Laboratory { // implements Favoritable
  const Laboratory._();

  const factory Laboratory({
    required int id,
    required String title,
    String? title2,
    ImageData? image,
    String? description,
    String? address,
    String? websiteurl,
    required Direction direction,
    List<Person>? persons,
    @JsonKey(name: 'learning_types') List<LearningType>? learningTypes,
    List<LaboratoryDay>? days,
  }) = _Laboratory;

  factory Laboratory.fromJson(Map<String, dynamic> json) =>
      _$LaboratoryFromJson(json);

  // НАШ НОВЫЙ ГЕТТЕР
  DateTime? get firstDayDate {
    if (days == null || days!.isEmpty) {
      return null;
    }
    // Сортируем дни по дате и берем самую первую
    final sortedDays = List<LaboratoryDay>.from(days!)
      ..sort((a, b) => a.date?.compareTo(b.date ?? DateTime(0)) ?? 0);
    return sortedDays.first.date;
  }

  DateTime? get lastDayDate {
    if (days == null || days!.isEmpty) {
      return null;
    }
    // Сортируем дни по дате и берем самую первую
    final sortedDays = List<LaboratoryDay>.from(days!)
      ..sort((a, b) => a.date?.compareTo(b.date ?? DateTime(0)) ?? 0);
    return sortedDays.last.date;
  }

  // int get favId => id;
  // EventType get favType => EventType.laboratory;
}
