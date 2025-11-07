// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Order {
  int? get id;
  String get name;
  String get email;
  String get phone;
  int get amount;
  String get type;
  Map<String, dynamic>? get details;
  String? get paymentId;
  String? get paymentStatus; // User? user,
  Festival? get festival;
  Laboratory? get laboratory;
  @JsonKey(name: 'product_in_stock')
  ProductInStock? get productInStock;
  DateTime? get createdAt;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderCopyWith<Order> get copyWith =>
      _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Order &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.details, details) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.festival, festival) ||
                other.festival == festival) &&
            (identical(other.laboratory, laboratory) ||
                other.laboratory == laboratory) &&
            (identical(other.productInStock, productInStock) ||
                other.productInStock == productInStock) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      phone,
      amount,
      type,
      const DeepCollectionEquality().hash(details),
      paymentId,
      paymentStatus,
      festival,
      laboratory,
      productInStock,
      createdAt);

  @override
  String toString() {
    return 'Order(id: $id, name: $name, email: $email, phone: $phone, amount: $amount, type: $type, details: $details, paymentId: $paymentId, paymentStatus: $paymentStatus, festival: $festival, laboratory: $laboratory, productInStock: $productInStock, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) =
      _$OrderCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String name,
      String email,
      String phone,
      int amount,
      String type,
      Map<String, dynamic>? details,
      String? paymentId,
      String? paymentStatus,
      Festival? festival,
      Laboratory? laboratory,
      @JsonKey(name: 'product_in_stock') ProductInStock? productInStock,
      DateTime? createdAt});

  $FestivalCopyWith<$Res>? get festival;
  $LaboratoryCopyWith<$Res>? get laboratory;
  $ProductInStockCopyWith<$Res>? get productInStock;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res> implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? amount = null,
    Object? type = null,
    Object? details = freezed,
    Object? paymentId = freezed,
    Object? paymentStatus = freezed,
    Object? festival = freezed,
    Object? laboratory = freezed,
    Object? productInStock = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      details: freezed == details
          ? _self.details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      paymentId: freezed == paymentId
          ? _self.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      festival: freezed == festival
          ? _self.festival
          : festival // ignore: cast_nullable_to_non_nullable
              as Festival?,
      laboratory: freezed == laboratory
          ? _self.laboratory
          : laboratory // ignore: cast_nullable_to_non_nullable
              as Laboratory?,
      productInStock: freezed == productInStock
          ? _self.productInStock
          : productInStock // ignore: cast_nullable_to_non_nullable
              as ProductInStock?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FestivalCopyWith<$Res>? get festival {
    if (_self.festival == null) {
      return null;
    }

    return $FestivalCopyWith<$Res>(_self.festival!, (value) {
      return _then(_self.copyWith(festival: value));
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LaboratoryCopyWith<$Res>? get laboratory {
    if (_self.laboratory == null) {
      return null;
    }

    return $LaboratoryCopyWith<$Res>(_self.laboratory!, (value) {
      return _then(_self.copyWith(laboratory: value));
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductInStockCopyWith<$Res>? get productInStock {
    if (_self.productInStock == null) {
      return null;
    }

    return $ProductInStockCopyWith<$Res>(_self.productInStock!, (value) {
      return _then(_self.copyWith(productInStock: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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
    TResult Function(_Order value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Order() when $default != null:
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
    TResult Function(_Order value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Order():
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
    TResult? Function(_Order value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Order() when $default != null:
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
    TResult Function(
            int? id,
            String name,
            String email,
            String phone,
            int amount,
            String type,
            Map<String, dynamic>? details,
            String? paymentId,
            String? paymentStatus,
            Festival? festival,
            Laboratory? laboratory,
            @JsonKey(name: 'product_in_stock') ProductInStock? productInStock,
            DateTime? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Order() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.email,
            _that.phone,
            _that.amount,
            _that.type,
            _that.details,
            _that.paymentId,
            _that.paymentStatus,
            _that.festival,
            _that.laboratory,
            _that.productInStock,
            _that.createdAt);
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
    TResult Function(
            int? id,
            String name,
            String email,
            String phone,
            int amount,
            String type,
            Map<String, dynamic>? details,
            String? paymentId,
            String? paymentStatus,
            Festival? festival,
            Laboratory? laboratory,
            @JsonKey(name: 'product_in_stock') ProductInStock? productInStock,
            DateTime? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Order():
        return $default(
            _that.id,
            _that.name,
            _that.email,
            _that.phone,
            _that.amount,
            _that.type,
            _that.details,
            _that.paymentId,
            _that.paymentStatus,
            _that.festival,
            _that.laboratory,
            _that.productInStock,
            _that.createdAt);
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
    TResult? Function(
            int? id,
            String name,
            String email,
            String phone,
            int amount,
            String type,
            Map<String, dynamic>? details,
            String? paymentId,
            String? paymentStatus,
            Festival? festival,
            Laboratory? laboratory,
            @JsonKey(name: 'product_in_stock') ProductInStock? productInStock,
            DateTime? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Order() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.email,
            _that.phone,
            _that.amount,
            _that.type,
            _that.details,
            _that.paymentId,
            _that.paymentStatus,
            _that.festival,
            _that.laboratory,
            _that.productInStock,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Order implements Order {
  const _Order(
      {this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.amount,
      required this.type,
      required final Map<String, dynamic>? details,
      this.paymentId,
      this.paymentStatus,
      this.festival,
      this.laboratory,
      @JsonKey(name: 'product_in_stock') this.productInStock,
      this.createdAt})
      : _details = details;
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String phone;
  @override
  final int amount;
  @override
  final String type;
  final Map<String, dynamic>? _details;
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? paymentId;
  @override
  final String? paymentStatus;
// User? user,
  @override
  final Festival? festival;
  @override
  final Laboratory? laboratory;
  @override
  @JsonKey(name: 'product_in_stock')
  final ProductInStock? productInStock;
  @override
  final DateTime? createdAt;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderCopyWith<_Order> get copyWith =>
      __$OrderCopyWithImpl<_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Order &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.festival, festival) ||
                other.festival == festival) &&
            (identical(other.laboratory, laboratory) ||
                other.laboratory == laboratory) &&
            (identical(other.productInStock, productInStock) ||
                other.productInStock == productInStock) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      phone,
      amount,
      type,
      const DeepCollectionEquality().hash(_details),
      paymentId,
      paymentStatus,
      festival,
      laboratory,
      productInStock,
      createdAt);

  @override
  String toString() {
    return 'Order(id: $id, name: $name, email: $email, phone: $phone, amount: $amount, type: $type, details: $details, paymentId: $paymentId, paymentStatus: $paymentStatus, festival: $festival, laboratory: $laboratory, productInStock: $productInStock, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) =
      __$OrderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      String email,
      String phone,
      int amount,
      String type,
      Map<String, dynamic>? details,
      String? paymentId,
      String? paymentStatus,
      Festival? festival,
      Laboratory? laboratory,
      @JsonKey(name: 'product_in_stock') ProductInStock? productInStock,
      DateTime? createdAt});

  @override
  $FestivalCopyWith<$Res>? get festival;
  @override
  $LaboratoryCopyWith<$Res>? get laboratory;
  @override
  $ProductInStockCopyWith<$Res>? get productInStock;
}

/// @nodoc
class __$OrderCopyWithImpl<$Res> implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? amount = null,
    Object? type = null,
    Object? details = freezed,
    Object? paymentId = freezed,
    Object? paymentStatus = freezed,
    Object? festival = freezed,
    Object? laboratory = freezed,
    Object? productInStock = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_Order(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      details: freezed == details
          ? _self._details
          : details // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      paymentId: freezed == paymentId
          ? _self.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      festival: freezed == festival
          ? _self.festival
          : festival // ignore: cast_nullable_to_non_nullable
              as Festival?,
      laboratory: freezed == laboratory
          ? _self.laboratory
          : laboratory // ignore: cast_nullable_to_non_nullable
              as Laboratory?,
      productInStock: freezed == productInStock
          ? _self.productInStock
          : productInStock // ignore: cast_nullable_to_non_nullable
              as ProductInStock?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FestivalCopyWith<$Res>? get festival {
    if (_self.festival == null) {
      return null;
    }

    return $FestivalCopyWith<$Res>(_self.festival!, (value) {
      return _then(_self.copyWith(festival: value));
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LaboratoryCopyWith<$Res>? get laboratory {
    if (_self.laboratory == null) {
      return null;
    }

    return $LaboratoryCopyWith<$Res>(_self.laboratory!, (value) {
      return _then(_self.copyWith(laboratory: value));
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductInStockCopyWith<$Res>? get productInStock {
    if (_self.productInStock == null) {
      return null;
    }

    return $ProductInStockCopyWith<$Res>(_self.productInStock!, (value) {
      return _then(_self.copyWith(productInStock: value));
    });
  }
}

// dart format on
