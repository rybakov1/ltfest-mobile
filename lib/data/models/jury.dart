// lib/models/jury.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jury.freezed.dart';

part 'jury.g.dart';

@freezed
abstract class Jury with _$Jury {
  const factory Jury({
    required int id,
    required String firstname,
    required String lastname,
    String? image,
    String? description,
  }) = _Jury;

  factory Jury.fromJson(Map<String, dynamic> json) => _$JuryFromJson(json);
}
