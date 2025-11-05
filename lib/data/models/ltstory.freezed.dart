// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ltstory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LTStory {
  int get id;
  String? get title;
  String? get url;
  List<ImageData>? get media;
  ImageData? get preview;
  Direction? get direction;

  /// Create a copy of LTStory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LTStoryCopyWith<LTStory> get copyWith =>
      _$LTStoryCopyWithImpl<LTStory>(this as LTStory, _$identity);

  /// Serializes this LTStory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LTStory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other.media, media) &&
            (identical(other.preview, preview) || other.preview == preview) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url,
      const DeepCollectionEquality().hash(media), preview, direction);

  @override
  String toString() {
    return 'LTStory(id: $id, title: $title, url: $url, media: $media, preview: $preview, direction: $direction)';
  }
}

/// @nodoc
abstract mixin class $LTStoryCopyWith<$Res> {
  factory $LTStoryCopyWith(LTStory value, $Res Function(LTStory) _then) =
      _$LTStoryCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String? title,
      String? url,
      List<ImageData>? media,
      ImageData? preview,
      Direction? direction});

  $ImageDataCopyWith<$Res>? get preview;
  $DirectionCopyWith<$Res>? get direction;
}

/// @nodoc
class _$LTStoryCopyWithImpl<$Res> implements $LTStoryCopyWith<$Res> {
  _$LTStoryCopyWithImpl(this._self, this._then);

  final LTStory _self;
  final $Res Function(LTStory) _then;

  /// Create a copy of LTStory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? url = freezed,
    Object? media = freezed,
    Object? preview = freezed,
    Object? direction = freezed,
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
      media: freezed == media
          ? _self.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<ImageData>?,
      preview: freezed == preview
          ? _self.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as ImageData?,
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
    ));
  }

  /// Create a copy of LTStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDataCopyWith<$Res>? get preview {
    if (_self.preview == null) {
      return null;
    }

    return $ImageDataCopyWith<$Res>(_self.preview!, (value) {
      return _then(_self.copyWith(preview: value));
    });
  }

  /// Create a copy of LTStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<$Res>? get direction {
    if (_self.direction == null) {
      return null;
    }

    return $DirectionCopyWith<$Res>(_self.direction!, (value) {
      return _then(_self.copyWith(direction: value));
    });
  }
}

/// Adds pattern-matching-related methods to [LTStory].
extension LTStoryPatterns on LTStory {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LTStory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LTStory() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LTStory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LTStory():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LTStory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LTStory() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String? title, String? url, List<ImageData>? media,
            ImageData? preview, Direction? direction)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LTStory() when $default != null:
        return $default(_that.id, _that.title, _that.url, _that.media,
            _that.preview, _that.direction);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String? title, String? url, List<ImageData>? media,
            ImageData? preview, Direction? direction)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LTStory():
        return $default(_that.id, _that.title, _that.url, _that.media,
            _that.preview, _that.direction);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String? title, String? url,
            List<ImageData>? media, ImageData? preview, Direction? direction)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LTStory() when $default != null:
        return $default(_that.id, _that.title, _that.url, _that.media,
            _that.preview, _that.direction);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LTStory implements LTStory {
  const _LTStory(
      {required this.id,
      this.title,
      this.url,
      final List<ImageData>? media,
      this.preview,
      this.direction})
      : _media = media;
  factory _LTStory.fromJson(Map<String, dynamic> json) =>
      _$LTStoryFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final String? url;
  final List<ImageData>? _media;
  @override
  List<ImageData>? get media {
    final value = _media;
    if (value == null) return null;
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ImageData? preview;
  @override
  final Direction? direction;

  /// Create a copy of LTStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LTStoryCopyWith<_LTStory> get copyWith =>
      __$LTStoryCopyWithImpl<_LTStory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LTStoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LTStory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.preview, preview) || other.preview == preview) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url,
      const DeepCollectionEquality().hash(_media), preview, direction);

  @override
  String toString() {
    return 'LTStory(id: $id, title: $title, url: $url, media: $media, preview: $preview, direction: $direction)';
  }
}

/// @nodoc
abstract mixin class _$LTStoryCopyWith<$Res> implements $LTStoryCopyWith<$Res> {
  factory _$LTStoryCopyWith(_LTStory value, $Res Function(_LTStory) _then) =
      __$LTStoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String? title,
      String? url,
      List<ImageData>? media,
      ImageData? preview,
      Direction? direction});

  @override
  $ImageDataCopyWith<$Res>? get preview;
  @override
  $DirectionCopyWith<$Res>? get direction;
}

/// @nodoc
class __$LTStoryCopyWithImpl<$Res> implements _$LTStoryCopyWith<$Res> {
  __$LTStoryCopyWithImpl(this._self, this._then);

  final _LTStory _self;
  final $Res Function(_LTStory) _then;

  /// Create a copy of LTStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? url = freezed,
    Object? media = freezed,
    Object? preview = freezed,
    Object? direction = freezed,
  }) {
    return _then(_LTStory(
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
      media: freezed == media
          ? _self._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<ImageData>?,
      preview: freezed == preview
          ? _self.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as ImageData?,
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
    ));
  }

  /// Create a copy of LTStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ImageDataCopyWith<$Res>? get preview {
    if (_self.preview == null) {
      return null;
    }

    return $ImageDataCopyWith<$Res>(_self.preview!, (value) {
      return _then(_self.copyWith(preview: value));
    });
  }

  /// Create a copy of LTStory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<$Res>? get direction {
    if (_self.direction == null) {
      return null;
    }

    return $DirectionCopyWith<$Res>(_self.direction!, (value) {
      return _then(_self.copyWith(direction: value));
    });
  }
}

// dart format on
