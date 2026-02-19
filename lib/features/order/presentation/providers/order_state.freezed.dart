// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderState {
  bool get isLoading;
  String? get errorMessage;
  String get payerName;
  String get email;
  String get phone;
  String get birthdate;
  String get residence;
  String get collectiveName;
  String get participantNames;
  int get seatCount;
  String get collectiveInfo;
  String get education;
  String get deliveryAddress;
  DeliveryMethod get deliveryMethod;
  OrderType get orderType;
  Festival? get selectedFestival;
  Laboratory? get laboratory;
  dynamic get payableItem;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderStateCopyWith<OrderState> get copyWith =>
      _$OrderStateCopyWithImpl<OrderState>(this as OrderState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.payerName, payerName) ||
                other.payerName == payerName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.residence, residence) ||
                other.residence == residence) &&
            (identical(other.collectiveName, collectiveName) ||
                other.collectiveName == collectiveName) &&
            (identical(other.participantNames, participantNames) ||
                other.participantNames == participantNames) &&
            (identical(other.seatCount, seatCount) ||
                other.seatCount == seatCount) &&
            (identical(other.collectiveInfo, collectiveInfo) ||
                other.collectiveInfo == collectiveInfo) &&
            (identical(other.education, education) ||
                other.education == education) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.deliveryMethod, deliveryMethod) ||
                other.deliveryMethod == deliveryMethod) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.selectedFestival, selectedFestival) ||
                other.selectedFestival == selectedFestival) &&
            (identical(other.laboratory, laboratory) ||
                other.laboratory == laboratory) &&
            const DeepCollectionEquality()
                .equals(other.payableItem, payableItem));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      errorMessage,
      payerName,
      email,
      phone,
      birthdate,
      residence,
      collectiveName,
      participantNames,
      seatCount,
      collectiveInfo,
      education,
      deliveryAddress,
      deliveryMethod,
      orderType,
      selectedFestival,
      laboratory,
      const DeepCollectionEquality().hash(payableItem));

  @override
  String toString() {
    return 'OrderState(isLoading: $isLoading, errorMessage: $errorMessage, payerName: $payerName, email: $email, phone: $phone, birthdate: $birthdate, residence: $residence, collectiveName: $collectiveName, participantNames: $participantNames, seatCount: $seatCount, collectiveInfo: $collectiveInfo, education: $education, deliveryAddress: $deliveryAddress, deliveryMethod: $deliveryMethod, orderType: $orderType, selectedFestival: $selectedFestival, laboratory: $laboratory, payableItem: $payableItem)';
  }
}

/// @nodoc
abstract mixin class $OrderStateCopyWith<$Res> {
  factory $OrderStateCopyWith(
          OrderState value, $Res Function(OrderState) _then) =
      _$OrderStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      String payerName,
      String email,
      String phone,
      String birthdate,
      String residence,
      String collectiveName,
      String participantNames,
      int seatCount,
      String collectiveInfo,
      String education,
      String deliveryAddress,
      DeliveryMethod deliveryMethod,
      OrderType orderType,
      Festival? selectedFestival,
      Laboratory? laboratory,
      dynamic payableItem});

  $FestivalCopyWith<$Res>? get selectedFestival;
  $LaboratoryCopyWith<$Res>? get laboratory;
}

/// @nodoc
class _$OrderStateCopyWithImpl<$Res> implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._self, this._then);

  final OrderState _self;
  final $Res Function(OrderState) _then;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? payerName = null,
    Object? email = null,
    Object? phone = null,
    Object? birthdate = null,
    Object? residence = null,
    Object? collectiveName = null,
    Object? participantNames = null,
    Object? seatCount = null,
    Object? collectiveInfo = null,
    Object? education = null,
    Object? deliveryAddress = null,
    Object? deliveryMethod = null,
    Object? orderType = null,
    Object? selectedFestival = freezed,
    Object? laboratory = freezed,
    Object? payableItem = freezed,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      payerName: null == payerName
          ? _self.payerName
          : payerName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: null == birthdate
          ? _self.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      residence: null == residence
          ? _self.residence
          : residence // ignore: cast_nullable_to_non_nullable
              as String,
      collectiveName: null == collectiveName
          ? _self.collectiveName
          : collectiveName // ignore: cast_nullable_to_non_nullable
              as String,
      participantNames: null == participantNames
          ? _self.participantNames
          : participantNames // ignore: cast_nullable_to_non_nullable
              as String,
      seatCount: null == seatCount
          ? _self.seatCount
          : seatCount // ignore: cast_nullable_to_non_nullable
              as int,
      collectiveInfo: null == collectiveInfo
          ? _self.collectiveInfo
          : collectiveInfo // ignore: cast_nullable_to_non_nullable
              as String,
      education: null == education
          ? _self.education
          : education // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryAddress: null == deliveryAddress
          ? _self.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryMethod: null == deliveryMethod
          ? _self.deliveryMethod
          : deliveryMethod // ignore: cast_nullable_to_non_nullable
              as DeliveryMethod,
      orderType: null == orderType
          ? _self.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as OrderType,
      selectedFestival: freezed == selectedFestival
          ? _self.selectedFestival
          : selectedFestival // ignore: cast_nullable_to_non_nullable
              as Festival?,
      laboratory: freezed == laboratory
          ? _self.laboratory
          : laboratory // ignore: cast_nullable_to_non_nullable
              as Laboratory?,
      payableItem: freezed == payableItem
          ? _self.payableItem
          : payableItem // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FestivalCopyWith<$Res>? get selectedFestival {
    if (_self.selectedFestival == null) {
      return null;
    }

    return $FestivalCopyWith<$Res>(_self.selectedFestival!, (value) {
      return _then(_self.copyWith(selectedFestival: value));
    });
  }

  /// Create a copy of OrderState
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
}

/// Adds pattern-matching-related methods to [OrderState].
extension OrderStatePatterns on OrderState {
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
    TResult Function(_OrderState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrderState() when $default != null:
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
    TResult Function(_OrderState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderState():
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
    TResult? Function(_OrderState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderState() when $default != null:
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
            bool isLoading,
            String? errorMessage,
            String payerName,
            String email,
            String phone,
            String birthdate,
            String residence,
            String collectiveName,
            String participantNames,
            int seatCount,
            String collectiveInfo,
            String education,
            String deliveryAddress,
            DeliveryMethod deliveryMethod,
            OrderType orderType,
            Festival? selectedFestival,
            Laboratory? laboratory,
            dynamic payableItem)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrderState() when $default != null:
        return $default(
            _that.isLoading,
            _that.errorMessage,
            _that.payerName,
            _that.email,
            _that.phone,
            _that.birthdate,
            _that.residence,
            _that.collectiveName,
            _that.participantNames,
            _that.seatCount,
            _that.collectiveInfo,
            _that.education,
            _that.deliveryAddress,
            _that.deliveryMethod,
            _that.orderType,
            _that.selectedFestival,
            _that.laboratory,
            _that.payableItem);
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
            bool isLoading,
            String? errorMessage,
            String payerName,
            String email,
            String phone,
            String birthdate,
            String residence,
            String collectiveName,
            String participantNames,
            int seatCount,
            String collectiveInfo,
            String education,
            String deliveryAddress,
            DeliveryMethod deliveryMethod,
            OrderType orderType,
            Festival? selectedFestival,
            Laboratory? laboratory,
            dynamic payableItem)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderState():
        return $default(
            _that.isLoading,
            _that.errorMessage,
            _that.payerName,
            _that.email,
            _that.phone,
            _that.birthdate,
            _that.residence,
            _that.collectiveName,
            _that.participantNames,
            _that.seatCount,
            _that.collectiveInfo,
            _that.education,
            _that.deliveryAddress,
            _that.deliveryMethod,
            _that.orderType,
            _that.selectedFestival,
            _that.laboratory,
            _that.payableItem);
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
            bool isLoading,
            String? errorMessage,
            String payerName,
            String email,
            String phone,
            String birthdate,
            String residence,
            String collectiveName,
            String participantNames,
            int seatCount,
            String collectiveInfo,
            String education,
            String deliveryAddress,
            DeliveryMethod deliveryMethod,
            OrderType orderType,
            Festival? selectedFestival,
            Laboratory? laboratory,
            dynamic payableItem)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderState() when $default != null:
        return $default(
            _that.isLoading,
            _that.errorMessage,
            _that.payerName,
            _that.email,
            _that.phone,
            _that.birthdate,
            _that.residence,
            _that.collectiveName,
            _that.participantNames,
            _that.seatCount,
            _that.collectiveInfo,
            _that.education,
            _that.deliveryAddress,
            _that.deliveryMethod,
            _that.orderType,
            _that.selectedFestival,
            _that.laboratory,
            _that.payableItem);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OrderState implements OrderState {
  const _OrderState(
      {this.isLoading = false,
      this.errorMessage = null,
      this.payerName = '',
      this.email = '',
      this.phone = '',
      this.birthdate = '',
      this.residence = '',
      this.collectiveName = '',
      this.participantNames = '',
      this.seatCount = 1,
      this.collectiveInfo = '',
      this.education = '',
      this.deliveryAddress = '',
      this.deliveryMethod = DeliveryMethod.onFestival,
      this.orderType = OrderType.products,
      this.selectedFestival,
      this.laboratory,
      this.payableItem});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String? errorMessage;
  @override
  @JsonKey()
  final String payerName;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String birthdate;
  @override
  @JsonKey()
  final String residence;
  @override
  @JsonKey()
  final String collectiveName;
  @override
  @JsonKey()
  final String participantNames;
  @override
  @JsonKey()
  final int seatCount;
  @override
  @JsonKey()
  final String collectiveInfo;
  @override
  @JsonKey()
  final String education;
  @override
  @JsonKey()
  final String deliveryAddress;
  @override
  @JsonKey()
  final DeliveryMethod deliveryMethod;
  @override
  @JsonKey()
  final OrderType orderType;
  @override
  final Festival? selectedFestival;
  @override
  final Laboratory? laboratory;
  @override
  final dynamic payableItem;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderStateCopyWith<_OrderState> get copyWith =>
      __$OrderStateCopyWithImpl<_OrderState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.payerName, payerName) ||
                other.payerName == payerName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.residence, residence) ||
                other.residence == residence) &&
            (identical(other.collectiveName, collectiveName) ||
                other.collectiveName == collectiveName) &&
            (identical(other.participantNames, participantNames) ||
                other.participantNames == participantNames) &&
            (identical(other.seatCount, seatCount) ||
                other.seatCount == seatCount) &&
            (identical(other.collectiveInfo, collectiveInfo) ||
                other.collectiveInfo == collectiveInfo) &&
            (identical(other.education, education) ||
                other.education == education) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.deliveryMethod, deliveryMethod) ||
                other.deliveryMethod == deliveryMethod) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.selectedFestival, selectedFestival) ||
                other.selectedFestival == selectedFestival) &&
            (identical(other.laboratory, laboratory) ||
                other.laboratory == laboratory) &&
            const DeepCollectionEquality()
                .equals(other.payableItem, payableItem));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      errorMessage,
      payerName,
      email,
      phone,
      birthdate,
      residence,
      collectiveName,
      participantNames,
      seatCount,
      collectiveInfo,
      education,
      deliveryAddress,
      deliveryMethod,
      orderType,
      selectedFestival,
      laboratory,
      const DeepCollectionEquality().hash(payableItem));

  @override
  String toString() {
    return 'OrderState(isLoading: $isLoading, errorMessage: $errorMessage, payerName: $payerName, email: $email, phone: $phone, birthdate: $birthdate, residence: $residence, collectiveName: $collectiveName, participantNames: $participantNames, seatCount: $seatCount, collectiveInfo: $collectiveInfo, education: $education, deliveryAddress: $deliveryAddress, deliveryMethod: $deliveryMethod, orderType: $orderType, selectedFestival: $selectedFestival, laboratory: $laboratory, payableItem: $payableItem)';
  }
}

/// @nodoc
abstract mixin class _$OrderStateCopyWith<$Res>
    implements $OrderStateCopyWith<$Res> {
  factory _$OrderStateCopyWith(
          _OrderState value, $Res Function(_OrderState) _then) =
      __$OrderStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      String payerName,
      String email,
      String phone,
      String birthdate,
      String residence,
      String collectiveName,
      String participantNames,
      int seatCount,
      String collectiveInfo,
      String education,
      String deliveryAddress,
      DeliveryMethod deliveryMethod,
      OrderType orderType,
      Festival? selectedFestival,
      Laboratory? laboratory,
      dynamic payableItem});

  @override
  $FestivalCopyWith<$Res>? get selectedFestival;
  @override
  $LaboratoryCopyWith<$Res>? get laboratory;
}

/// @nodoc
class __$OrderStateCopyWithImpl<$Res> implements _$OrderStateCopyWith<$Res> {
  __$OrderStateCopyWithImpl(this._self, this._then);

  final _OrderState _self;
  final $Res Function(_OrderState) _then;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? payerName = null,
    Object? email = null,
    Object? phone = null,
    Object? birthdate = null,
    Object? residence = null,
    Object? collectiveName = null,
    Object? participantNames = null,
    Object? seatCount = null,
    Object? collectiveInfo = null,
    Object? education = null,
    Object? deliveryAddress = null,
    Object? deliveryMethod = null,
    Object? orderType = null,
    Object? selectedFestival = freezed,
    Object? laboratory = freezed,
    Object? payableItem = freezed,
  }) {
    return _then(_OrderState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      payerName: null == payerName
          ? _self.payerName
          : payerName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: null == birthdate
          ? _self.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      residence: null == residence
          ? _self.residence
          : residence // ignore: cast_nullable_to_non_nullable
              as String,
      collectiveName: null == collectiveName
          ? _self.collectiveName
          : collectiveName // ignore: cast_nullable_to_non_nullable
              as String,
      participantNames: null == participantNames
          ? _self.participantNames
          : participantNames // ignore: cast_nullable_to_non_nullable
              as String,
      seatCount: null == seatCount
          ? _self.seatCount
          : seatCount // ignore: cast_nullable_to_non_nullable
              as int,
      collectiveInfo: null == collectiveInfo
          ? _self.collectiveInfo
          : collectiveInfo // ignore: cast_nullable_to_non_nullable
              as String,
      education: null == education
          ? _self.education
          : education // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryAddress: null == deliveryAddress
          ? _self.deliveryAddress
          : deliveryAddress // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryMethod: null == deliveryMethod
          ? _self.deliveryMethod
          : deliveryMethod // ignore: cast_nullable_to_non_nullable
              as DeliveryMethod,
      orderType: null == orderType
          ? _self.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as OrderType,
      selectedFestival: freezed == selectedFestival
          ? _self.selectedFestival
          : selectedFestival // ignore: cast_nullable_to_non_nullable
              as Festival?,
      laboratory: freezed == laboratory
          ? _self.laboratory
          : laboratory // ignore: cast_nullable_to_non_nullable
              as Laboratory?,
      payableItem: freezed == payableItem
          ? _self.payableItem
          : payableItem // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FestivalCopyWith<$Res>? get selectedFestival {
    if (_self.selectedFestival == null) {
      return null;
    }

    return $FestivalCopyWith<$Res>(_self.selectedFestival!, (value) {
      return _then(_self.copyWith(selectedFestival: value));
    });
  }

  /// Create a copy of OrderState
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
}

// dart format on
