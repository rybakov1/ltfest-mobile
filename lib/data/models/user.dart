// import 'direction.dart';
// import 'activity.dart';
//
// class User {
//   final int id;
//   final String? firstname;
//   final String? lastname;
//   final String? email;
//   final DateTime? birthdate;
//   final String? residence;
//   final String? phone;
//   final Activity? activity;
//   final Direction? direction;
//   final String? collectiveName;
//   final String? collectiveCity;
//   final String? ltpriority;
//   final String? educationPlace;
//   final String? masterName;
//
//   User({
//     required this.id,
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     this.birthdate,
//     this.residence,
//     this.phone,
//     this.activity,
//     this.direction,
//     this.collectiveName,
//     this.collectiveCity,
//     this.ltpriority,
//     this.educationPlace,
//     this.masterName,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       firstname: json['firstname'],
//       lastname: json['lastname'],
//       email: json['email'],
//       birthdate:
//           json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
//       residence: json['residence'],
//       phone: json['phone'],
//       direction: json['direction'] != null ? Direction.fromJson(json['direction']) : null,
//       activity: json['activity'] != null ? Activity.fromJson(json['activity']) : null,
//       collectiveName: json['collectiveName'],
//       collectiveCity: json['collectiveCity'],
//       ltpriority: json['ltpriority'],
//       educationPlace: json['educationPlace'],
//       masterName: json['masterName'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'firstname': firstname,
//       'lastname': lastname,
//       'email': email,
//       'birthdate': birthdate!.toIso8601String().split('T')[0], // Формат YYYY-MM-DD
//       'residence': residence,
//       'phone': phone,
//       'direction': direction,
//       'activity': activity,
//       'collectiveName': collectiveName,
//       'collectiveCity': collectiveCity,
//       'ltpriority': ltpriority,
//       'educationPlace': educationPlace,
//       'masterName': masterName,
//     };
//   }
// }
import 'package:freezed_annotation/freezed_annotation.dart';
import 'direction.dart';
import 'activity.dart';
import 'favorite_festival.dart';
import 'favorite_laboratory.dart';
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
    @Default([]) @JsonKey(name: 'favourites_festivals') List<Festival>? favouritesFestivals,
    @Default([]) @JsonKey(name: 'favourites_laboratories') List<Laboratory>? favouritesLaboratories,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}