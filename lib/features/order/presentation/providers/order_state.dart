import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ltfest/data/models/festival_tariff.dart';
import 'package:ltfest/data/models/laboratory_learning_type.dart';
import 'package:ltfest/data/models/user.dart';
import 'package:ltfest/pages/cart/models/cart.dart';
import '../../domain/entities/order_info.dart';
import '../../domain/entities/order_enums.dart';
import '../../../../data/models/festival.dart';
import '../../../../data/models/laboratory.dart';

part 'order_state.freezed.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState({
    @Default(false) bool isLoading,
    @Default(null) String? errorMessage,
    @Default('') String payerName,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String birthdate,
    @Default('') String residence,
    @Default('') String collectiveName,
    @Default('') String participantNames,
    @Default(1) int seatCount,
    @Default('') String collectiveInfo,
    @Default('') String education,
    @Default('') String deliveryAddress,
    @Default(DeliveryMethod.onFestival) DeliveryMethod deliveryMethod,
    @Default(OrderType.products) OrderType orderType,
    Festival? selectedFestival,
    Laboratory? laboratory,
    dynamic payableItem,
  }) = _OrderState;
}
