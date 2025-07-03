import 'package:freezed_annotation/freezed_annotation.dart';

part 'news.freezed.dart';
part 'news.g.dart';

@freezed
abstract class News with _$News {
  const factory News({
    required int id,
    required String title,
    required DateTime date,
    String? image,
    String? url,
    String? description,
  }) = _News;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}
