import 'package:freezed_annotation/freezed_annotation.dart';

import 'direction.dart';
import 'jury.dart';

part 'festival.freezed.dart';

part 'festival.g.dart';

@freezed
abstract class Festival with _$Festival {
  const factory Festival(
      {required int id,
      required String title,
      String? image,
      required int price,
      required String date,
      String? address,
      String? description,
      String? pdfurl,
      @JsonKey(name: 'direction') required Direction direction,
      required List<Jury> jury}) = _Festival;

  factory Festival.fromJson(Map<String, dynamic> json) =>
      _$FestivalFromJson(json);
}
