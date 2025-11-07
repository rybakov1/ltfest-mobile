import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature.freezed.dart';
part 'feature.g.dart';

@freezed
abstract class Feature with _$Feature {
  const factory Feature({
    required int id,
    required String title,
    // Добавьте сюда другие поля вашего компонента, например, 'icon', 'description'
  }) = _Feature;

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
}