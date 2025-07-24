import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_data.dart';

part 'ltbanner.freezed.dart';
part 'ltbanner.g.dart';

@freezed
abstract class LTBanner with _$LTBanner {
  const factory LTBanner({
    required int id,
    String? title,
    String? url,
    ImageData? image,
  }) = _LTBanner;

  factory LTBanner.fromJson(Map<String, dynamic> json) =>
      _$LTBannerFromJson(json);
}
