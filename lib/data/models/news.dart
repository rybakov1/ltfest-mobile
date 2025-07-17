import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/image_data.dart';

part 'news.freezed.dart';
part 'news.g.dart';

@freezed
abstract class News with _$News {
  const factory News({
    required int id,
    required String title,
    required DateTime date,
    ImageData? image,
    String? url,
    String? description,
  }) = _News;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}
