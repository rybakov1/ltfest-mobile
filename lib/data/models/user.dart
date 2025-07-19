import 'direction.dart';
import 'activity.dart';

class User {
  final int id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final DateTime? birthdate;
  final String? residence;
  final String? phone;
  final Activity? activity;
  final Direction? direction;
  final String? collectiveName;
  final String? collectiveCity;
  final String? ltpriority;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.birthdate,
    this.residence,
    this.phone,
    this.activity,
    this.direction,
    this.collectiveName,
    this.collectiveCity,
    this.ltpriority,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      birthdate: json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      residence: json['residence'],
      phone: json['phone'],
      direction: json['direction'] != null
          ? Direction.fromJson(json['direction'])
          : null,

      activity: json['activity'] != null
          ? Activity.fromJson(json['activity'])
          : null,
      collectiveName: json['collectiveName'],
      collectiveCity: json['collectiveCity'],
      ltpriority: json['ltpriority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'birthdate': birthdate!.toIso8601String().split('T')[0],  // Формат YYYY-MM-DD
      'residence': residence,
      'phone': phone,
      'direction': direction,
      'activity': activity,
      'collectiveName': collectiveName,
      'collectiveCity': collectiveCity,
      'ltpriority': ltpriority,
    };
  }
}