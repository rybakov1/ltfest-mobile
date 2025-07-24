// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ltbanner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LTBanner {
  int get id;
  String? get title;
  String? get url;
  ImageData? get image;

  /// Create a copy of LTBanner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LTBannerCopyWith<LTBanner> get copyWith =>
      _$LTBannerCopyWithImpl<LTBanner>(this as LTBanner, _$identity);

  /// Serializes this LTBanner to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LTBanner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, image);

  @override
  String toString() {
    return 'LTBanner(id: $id, title: $title, url: $url, image: $image)';
  }
}

/// @nodoc
abstract mixin class $LTBannerCopyWith<$Res> {
  factory $LTBannerCopyWith(LTBanner value, $Res Function(LTBanner) _then) =
      _$LTBannerCopyWithImpl;
  @useResult
  $Res call({int id, String? title, String? url, ImageData? image});

  $ImageDataCopyWith<$Res>? get image;
}

/// @nodoc
class _$LTBannerCopyWithImpl<$Res> implements $LTBannerCopyWith<$Res> {
  _$LTBannerCopyWithImpl(this._self, this._then);

  final LTBanner _self;
  final $Res Function(LTBanner) _then;

  /// Create a copy of LTBanner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? url = freezed,
    Object? image = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as ImageData?,
    ));
  }

  /// Create a copy of LTBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDataCopyWith<$Res>? get image {
    if (_self.image == null) {
      return null;
    }

    return $ImageDataCopyWith<$Res>(_self.image!, (value) {
      return _then(_self.copyWith(image: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _LTBanner implements LTBanner {
  const _LTBanner({required this.id, this.title, this.url, this.image});
  factory _LTBanner.fromJson(Map<String, dynamic> json) =>
      _$LTBannerFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final String? url;
  @override
  final ImageData? image;

  /// Create a copy of LTBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LTBannerCopyWith<_LTBanner> get copyWith =>
      __$LTBannerCopyWithImpl<_LTBanner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LTBannerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LTBanner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, image);

  @override
  String toString() {
    return 'LTBanner(id: $id, title: $title, url: $url, image: $image)';
  }
}

/// @nodoc
abstract mixin class _$LTBannerCopyWith<$Res>
    implements $LTBannerCopyWith<$Res> {
  factory _$LTBannerCopyWith(_LTBanner value, $Res Function(_LTBanner) _then) =
      __$LTBannerCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String? title, String? url, ImageData? image});

  @override
  $ImageDataCopyWith<$Res>? get image;
}

/// @nodoc
class __$LTBannerCopyWithImpl<$Res> implements _$LTBannerCopyWith<$Res> {
  __$LTBannerCopyWithImpl(this._self, this._then);

  final _LTBanner _self;
  final $Res Function(_LTBanner) _then;

  /// Create a copy of LTBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? url = freezed,
    Object? image = freezed,
  }) {
    return _then(_LTBanner(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as ImageData?,
    ));
  }

  /// Create a copy of LTBanner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDataCopyWith<$Res>? get image {
    if (_self.image == null) {
      return null;
    }

    return $ImageDataCopyWith<$Res>(_self.image!, (value) {
      return _then(_self.copyWith(image: value));
    });
  }
}

// dart format on
