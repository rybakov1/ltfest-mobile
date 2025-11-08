import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/feature.dart';

part 'priority_tariff.freezed.dart';
part 'priority_tariff.g.dart';

@freezed
abstract class PriorityTariff with _$PriorityTariff {
  const factory PriorityTariff({
    required int id,
    required String title,
    required String description,
    required double price,
    required List<Feature> features,
  }) = _PriorityTariff;

  factory PriorityTariff.fromJson(Map<String, dynamic> json) =>
      _$PriorityTariffFromJson(json);
}
