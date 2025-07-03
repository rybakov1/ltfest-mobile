// lib/models/jury.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'direction.freezed.dart';

part 'direction.g.dart';

@freezed
abstract class Direction with _$Direction {
  const factory Direction({
    required int id,
    required String title,
  }) = _Direction;

  factory Direction.fromJson(Map<String, dynamic> json) =>
      _$DirectionFromJson(json);
}
