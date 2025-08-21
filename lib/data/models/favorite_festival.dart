import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'favorite_festival.freezed.dart';
part 'favorite_festival.g.dart';

@freezed
abstract class FavoriteFestival with _$FavoriteFestival {
  const factory FavoriteFestival({
    required int id,
    required String title,
    String? address,
    required int price,
    @JsonKey(name: 'date_start') DateTime? dateStart,
    @JsonKey(name: 'date_end') DateTime? dateEnd,
    String? description,
    String? pdfurl,
    String? entryurl,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime publishedAt,
  }) = _FavoriteFestival;

  factory FavoriteFestival.fromJson(Map<String, dynamic> json) => _$FavoriteFestivalFromJson(json);
}