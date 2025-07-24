import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_data.freezed.dart';
part 'image_data.g.dart';

@freezed
abstract class ImageData with _$ImageData {
  const factory ImageData({
    required int id,
    required String url,
    required String mime,
    ImageFormats? formats,
  }) = _ImageData;

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);
}

@freezed
abstract class ImageFormats with _$ImageFormats {
  const factory ImageFormats({
    ImageFormat? thumbnail,
    ImageFormat? small,
    ImageFormat? medium,
  }) = _ImageFormats;

  factory ImageFormats.fromJson(Map<String, dynamic> json) =>
      _$ImageFormatsFromJson(json);
}

@freezed
abstract class ImageFormat with _$ImageFormat {
  const factory ImageFormat({
    required String url,
  }) = _ImageFormat;

  factory ImageFormat.fromJson(Map<String, dynamic> json) =>
      _$ImageFormatFromJson(json);
}