// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageData {
  int get id;
  String get url;
  String get mime;
  ImageFormats? get formats;

  /// Create a copy of ImageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageDataCopyWith<ImageData> get copyWith =>
      _$ImageDataCopyWithImpl<ImageData>(this as ImageData, _$identity);

  /// Serializes this ImageData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.mime, mime) || other.mime == mime) &&
            (identical(other.formats, formats) || other.formats == formats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, mime, formats);

  @override
  String toString() {
    return 'ImageData(id: $id, url: $url, mime: $mime, formats: $formats)';
  }
}

/// @nodoc
abstract mixin class $ImageDataCopyWith<$Res> {
  factory $ImageDataCopyWith(ImageData value, $Res Function(ImageData) _then) =
      _$ImageDataCopyWithImpl;
  @useResult
  $Res call({int id, String url, String mime, ImageFormats? formats});

  $ImageFormatsCopyWith<$Res>? get formats;
}

/// @nodoc
class _$ImageDataCopyWithImpl<$Res> implements $ImageDataCopyWith<$Res> {
  _$ImageDataCopyWithImpl(this._self, this._then);

  final ImageData _self;
  final $Res Function(ImageData) _then;

  /// Create a copy of ImageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? mime = null,
    Object? formats = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      mime: null == mime
          ? _self.mime
          : mime // ignore: cast_nullable_to_non_nullable
              as String,
      formats: freezed == formats
          ? _self.formats
          : formats // ignore: cast_nullable_to_non_nullable
              as ImageFormats?,
    ));
  }

  /// Create a copy of ImageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageFormatsCopyWith<$Res>? get formats {
    if (_self.formats == null) {
      return null;
    }

    return $ImageFormatsCopyWith<$Res>(_self.formats!, (value) {
      return _then(_self.copyWith(formats: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ImageData implements ImageData {
  const _ImageData(
      {required this.id, required this.url, required this.mime, this.formats});
  factory _ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);

  @override
  final int id;
  @override
  final String url;
  @override
  final String mime;
  @override
  final ImageFormats? formats;

  /// Create a copy of ImageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageDataCopyWith<_ImageData> get copyWith =>
      __$ImageDataCopyWithImpl<_ImageData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImageDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.mime, mime) || other.mime == mime) &&
            (identical(other.formats, formats) || other.formats == formats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, mime, formats);

  @override
  String toString() {
    return 'ImageData(id: $id, url: $url, mime: $mime, formats: $formats)';
  }
}

/// @nodoc
abstract mixin class _$ImageDataCopyWith<$Res>
    implements $ImageDataCopyWith<$Res> {
  factory _$ImageDataCopyWith(
          _ImageData value, $Res Function(_ImageData) _then) =
      __$ImageDataCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String url, String mime, ImageFormats? formats});

  @override
  $ImageFormatsCopyWith<$Res>? get formats;
}

/// @nodoc
class __$ImageDataCopyWithImpl<$Res> implements _$ImageDataCopyWith<$Res> {
  __$ImageDataCopyWithImpl(this._self, this._then);

  final _ImageData _self;
  final $Res Function(_ImageData) _then;

  /// Create a copy of ImageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? mime = null,
    Object? formats = freezed,
  }) {
    return _then(_ImageData(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      mime: null == mime
          ? _self.mime
          : mime // ignore: cast_nullable_to_non_nullable
              as String,
      formats: freezed == formats
          ? _self.formats
          : formats // ignore: cast_nullable_to_non_nullable
              as ImageFormats?,
    ));
  }

  /// Create a copy of ImageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageFormatsCopyWith<$Res>? get formats {
    if (_self.formats == null) {
      return null;
    }

    return $ImageFormatsCopyWith<$Res>(_self.formats!, (value) {
      return _then(_self.copyWith(formats: value));
    });
  }
}

/// @nodoc
mixin _$ImageFormats {
  ImageFormat? get thumbnail;
  ImageFormat? get small;
  ImageFormat? get medium;

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageFormatsCopyWith<ImageFormats> get copyWith =>
      _$ImageFormatsCopyWithImpl<ImageFormats>(
          this as ImageFormats, _$identity);

  /// Serializes this ImageFormats to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageFormats &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.small, small) || other.small == small) &&
            (identical(other.medium, medium) || other.medium == medium));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, thumbnail, small, medium);

  @override
  String toString() {
    return 'ImageFormats(thumbnail: $thumbnail, small: $small, medium: $medium)';
  }
}

/// @nodoc
abstract mixin class $ImageFormatsCopyWith<$Res> {
  factory $ImageFormatsCopyWith(
          ImageFormats value, $Res Function(ImageFormats) _then) =
      _$ImageFormatsCopyWithImpl;
  @useResult
  $Res call({ImageFormat? thumbnail, ImageFormat? small, ImageFormat? medium});

  $ImageFormatCopyWith<$Res>? get thumbnail;
  $ImageFormatCopyWith<$Res>? get small;
  $ImageFormatCopyWith<$Res>? get medium;
}

/// @nodoc
class _$ImageFormatsCopyWithImpl<$Res> implements $ImageFormatsCopyWith<$Res> {
  _$ImageFormatsCopyWithImpl(this._self, this._then);

  final ImageFormats _self;
  final $Res Function(ImageFormats) _then;

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? thumbnail = freezed,
    Object? small = freezed,
    Object? medium = freezed,
  }) {
    return _then(_self.copyWith(
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as ImageFormat?,
      small: freezed == small
          ? _self.small
          : small // ignore: cast_nullable_to_non_nullable
              as ImageFormat?,
      medium: freezed == medium
          ? _self.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as ImageFormat?,
    ));
  }

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageFormatCopyWith<$Res>? get thumbnail {
    if (_self.thumbnail == null) {
      return null;
    }

    return $ImageFormatCopyWith<$Res>(_self.thumbnail!, (value) {
      return _then(_self.copyWith(thumbnail: value));
    });
  }

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageFormatCopyWith<$Res>? get small {
    if (_self.small == null) {
      return null;
    }

    return $ImageFormatCopyWith<$Res>(_self.small!, (value) {
      return _then(_self.copyWith(small: value));
    });
  }

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageFormatCopyWith<$Res>? get medium {
    if (_self.medium == null) {
      return null;
    }

    return $ImageFormatCopyWith<$Res>(_self.medium!, (value) {
      return _then(_self.copyWith(medium: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ImageFormats implements ImageFormats {
  const _ImageFormats({this.thumbnail, this.small, this.medium});
  factory _ImageFormats.fromJson(Map<String, dynamic> json) =>
      _$ImageFormatsFromJson(json);

  @override
  final ImageFormat? thumbnail;
  @override
  final ImageFormat? small;
  @override
  final ImageFormat? medium;

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageFormatsCopyWith<_ImageFormats> get copyWith =>
      __$ImageFormatsCopyWithImpl<_ImageFormats>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImageFormatsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageFormats &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.small, small) || other.small == small) &&
            (identical(other.medium, medium) || other.medium == medium));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, thumbnail, small, medium);

  @override
  String toString() {
    return 'ImageFormats(thumbnail: $thumbnail, small: $small, medium: $medium)';
  }
}

/// @nodoc
abstract mixin class _$ImageFormatsCopyWith<$Res>
    implements $ImageFormatsCopyWith<$Res> {
  factory _$ImageFormatsCopyWith(
          _ImageFormats value, $Res Function(_ImageFormats) _then) =
      __$ImageFormatsCopyWithImpl;
  @override
  @useResult
  $Res call({ImageFormat? thumbnail, ImageFormat? small, ImageFormat? medium});

  @override
  $ImageFormatCopyWith<$Res>? get thumbnail;
  @override
  $ImageFormatCopyWith<$Res>? get small;
  @override
  $ImageFormatCopyWith<$Res>? get medium;
}

/// @nodoc
class __$ImageFormatsCopyWithImpl<$Res>
    implements _$ImageFormatsCopyWith<$Res> {
  __$ImageFormatsCopyWithImpl(this._self, this._then);

  final _ImageFormats _self;
  final $Res Function(_ImageFormats) _then;

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? thumbnail = freezed,
    Object? small = freezed,
    Object? medium = freezed,
  }) {
    return _then(_ImageFormats(
      thumbnail: freezed == thumbnail
          ? _self.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as ImageFormat?,
      small: freezed == small
          ? _self.small
          : small // ignore: cast_nullable_to_non_nullable
              as ImageFormat?,
      medium: freezed == medium
          ? _self.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as ImageFormat?,
    ));
  }

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageFormatCopyWith<$Res>? get thumbnail {
    if (_self.thumbnail == null) {
      return null;
    }

    return $ImageFormatCopyWith<$Res>(_self.thumbnail!, (value) {
      return _then(_self.copyWith(thumbnail: value));
    });
  }

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageFormatCopyWith<$Res>? get small {
    if (_self.small == null) {
      return null;
    }

    return $ImageFormatCopyWith<$Res>(_self.small!, (value) {
      return _then(_self.copyWith(small: value));
    });
  }

  /// Create a copy of ImageFormats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageFormatCopyWith<$Res>? get medium {
    if (_self.medium == null) {
      return null;
    }

    return $ImageFormatCopyWith<$Res>(_self.medium!, (value) {
      return _then(_self.copyWith(medium: value));
    });
  }
}

/// @nodoc
mixin _$ImageFormat {
  String get url;

  /// Create a copy of ImageFormat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageFormatCopyWith<ImageFormat> get copyWith =>
      _$ImageFormatCopyWithImpl<ImageFormat>(this as ImageFormat, _$identity);

  /// Serializes this ImageFormat to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageFormat &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @override
  String toString() {
    return 'ImageFormat(url: $url)';
  }
}

/// @nodoc
abstract mixin class $ImageFormatCopyWith<$Res> {
  factory $ImageFormatCopyWith(
          ImageFormat value, $Res Function(ImageFormat) _then) =
      _$ImageFormatCopyWithImpl;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$ImageFormatCopyWithImpl<$Res> implements $ImageFormatCopyWith<$Res> {
  _$ImageFormatCopyWithImpl(this._self, this._then);

  final ImageFormat _self;
  final $Res Function(ImageFormat) _then;

  /// Create a copy of ImageFormat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ImageFormat implements ImageFormat {
  const _ImageFormat({required this.url});
  factory _ImageFormat.fromJson(Map<String, dynamic> json) =>
      _$ImageFormatFromJson(json);

  @override
  final String url;

  /// Create a copy of ImageFormat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageFormatCopyWith<_ImageFormat> get copyWith =>
      __$ImageFormatCopyWithImpl<_ImageFormat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImageFormatToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageFormat &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @override
  String toString() {
    return 'ImageFormat(url: $url)';
  }
}

/// @nodoc
abstract mixin class _$ImageFormatCopyWith<$Res>
    implements $ImageFormatCopyWith<$Res> {
  factory _$ImageFormatCopyWith(
          _ImageFormat value, $Res Function(_ImageFormat) _then) =
      __$ImageFormatCopyWithImpl;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$ImageFormatCopyWithImpl<$Res> implements _$ImageFormatCopyWith<$Res> {
  __$ImageFormatCopyWithImpl(this._self, this._then);

  final _ImageFormat _self;
  final $Res Function(_ImageFormat) _then;

  /// Create a copy of ImageFormat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
  }) {
    return _then(_ImageFormat(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
