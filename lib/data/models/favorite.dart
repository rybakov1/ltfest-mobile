import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/direction.dart'; // Убедитесь, что импорт правильный

part 'favorite.freezed.dart';
part 'favorite.g.dart';

@freezed
abstract class Favorite with _$Favorite {
  const factory Favorite({
    required int id,
    required int favoriteId,
    required String type,
    required String title,
    String? image,
    // Поля для фестивалей и лабораторий
    String? date_start,
    String? date_end,
    String? address,
    Direction? direction,
    // Поля для продуктов
    double? price,
    String? article, // <-- Добавлено это поле
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}