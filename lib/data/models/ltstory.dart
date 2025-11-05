import 'package:freezed_annotation/freezed_annotation.dart';

import 'direction.dart';
import 'image_data.dart';

part 'ltstory.freezed.dart';
part 'ltstory.g.dart';

@freezed
abstract class LTStory with _$LTStory {
  const factory LTStory({
    required int id,
    String? title,
    String? url,
    List<ImageData>? media,
    ImageData? preview,
    Direction? direction,
  }) = _LTStory;

  factory LTStory.fromJson(Map<String, dynamic> json) =>
      _$LTStoryFromJson(json);
}
