// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$News {
  int get id;
  String get title;
  DateTime get date;
  String? get image;
  String? get url;
  String? get description;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NewsCopyWith<News> get copyWith =>
      _$NewsCopyWithImpl<News>(this as News, _$identity);

  /// Serializes this News to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is News &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, date, image, url, description);

  @override
  String toString() {
    return 'News(id: $id, title: $title, date: $date, image: $image, url: $url, description: $description)';
  }
}

/// @nodoc
abstract mixin class $NewsCopyWith<$Res> {
  factory $NewsCopyWith(News value, $Res Function(News) _then) =
      _$NewsCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      DateTime date,
      String? image,
      String? url,
      String? description});
}

/// @nodoc
class _$NewsCopyWithImpl<$Res> implements $NewsCopyWith<$Res> {
  _$NewsCopyWithImpl(this._self, this._then);

  final News _self;
  final $Res Function(News) _then;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? image = freezed,
    Object? url = freezed,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _News implements News {
  const _News(
      {required this.id,
      required this.title,
      required this.date,
      this.image,
      this.url,
      this.description});
  factory _News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final DateTime date;
  @override
  final String? image;
  @override
  final String? url;
  @override
  final String? description;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NewsCopyWith<_News> get copyWith =>
      __$NewsCopyWithImpl<_News>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NewsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _News &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, date, image, url, description);

  @override
  String toString() {
    return 'News(id: $id, title: $title, date: $date, image: $image, url: $url, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$NewsCopyWith<$Res> implements $NewsCopyWith<$Res> {
  factory _$NewsCopyWith(_News value, $Res Function(_News) _then) =
      __$NewsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      DateTime date,
      String? image,
      String? url,
      String? description});
}

/// @nodoc
class __$NewsCopyWithImpl<$Res> implements _$NewsCopyWith<$Res> {
  __$NewsCopyWithImpl(this._self, this._then);

  final _News _self;
  final $Res Function(_News) _then;

  /// Create a copy of News
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? image = freezed,
    Object? url = freezed,
    Object? description = freezed,
  }) {
    return _then(_News(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
