import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'favorite_laboratory.freezed.dart';
part 'favorite_laboratory.g.dart';

@freezed
abstract class FavoriteLaboratory with _$FavoriteLaboratory {
  const factory FavoriteLaboratory({
    required int id,
    required String title,
    String? description,
    String? address,
    String? url,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime publishedAt,
  }) = _FavoriteLaboratory;

  factory FavoriteLaboratory.fromJson(Map<String, dynamic> json) => _$FavoriteLaboratoryFromJson(json);
}