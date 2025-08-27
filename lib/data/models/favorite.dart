import 'package:freezed_annotation/freezed_annotation.dart';

import 'direction.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

// Модель для Event
@freezed
abstract class Favorite with _$Favorite {
  const factory Favorite({
    required int id,
    required String title,
    required String type,
    @JsonKey(name: 'date_start') required String dateStart,
    @JsonKey(name: 'date_end') required String dateEnd,
    String? image,
    String? address,
    Direction? direction,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);
}