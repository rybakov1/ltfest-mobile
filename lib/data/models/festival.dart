import 'package:freezed_annotation/freezed_annotation.dart';

import 'direction.dart';
import 'image_data.dart';
import 'person.dart';

part 'festival.freezed.dart';

part 'festival.g.dart';

@freezed
abstract class Festival with _$Festival {
    const factory Festival({
        required int id,
        required String title,
        ImageData? image,
        required int price,
        @JsonKey(name: "date_start") DateTime? dateStart,
        @JsonKey(name: "date_end") DateTime? dateEnd,
        String? address,
        String? description,
        String? pdfurl,
        required Direction direction,
        List<Person>? persons,
    }) = _Festival;

    factory Festival.fromJson(Map<String, dynamic> json) =>
        _$FestivalFromJson(json);
}
