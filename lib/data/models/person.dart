import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_data.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
abstract class Person with _$Person {
  const factory Person({
    required int id,
    required String firstname,
    required String lastname,
    ImageData? image,
    String? description,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}