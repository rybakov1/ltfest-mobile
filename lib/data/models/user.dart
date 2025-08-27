import 'package:freezed_annotation/freezed_annotation.dart';
import 'direction.dart';
import 'activity.dart';
import 'festival.dart';
import 'laboratory.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    String? firstname,
    String? lastname,
    String? email,
    DateTime? birthdate,
    String? residence,
    String? phone,
    Activity? activity,
    Direction? direction,
    String? collectiveName,
    String? collectiveCity,
    String? ltpriority,
    String? educationPlace,
    String? masterName,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}