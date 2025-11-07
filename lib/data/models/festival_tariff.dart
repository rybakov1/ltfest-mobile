import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/feature.dart';

part 'festival_tariff.freezed.dart';
part 'festival_tariff.g.dart';

@freezed
abstract class FestivalTariff with _$FestivalTariff {
  const factory FestivalTariff({
    required int id,
    required String title,
    required String description,
    required double price,
    required List<Feature> feature,
  }) = _FestivalTariff;

  factory FestivalTariff.fromJson(Map<String, dynamic> json) =>
      _$FestivalTariffFromJson(json);
}
