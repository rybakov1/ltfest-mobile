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
  final Activity activity;
  final Direction direction;
  final String? collectiveName;
  final String? collectiveCity;
  final String? ltpriority;
  final String? educationPlace;
  final String? masterName;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.birthdate,
    this.residence,
    this.phone,
    required this.activity,
    required this.direction,
    this.collectiveName,
    this.collectiveCity,
    this.ltpriority,
    this.educationPlace,
    this.masterName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      birthdate:
          json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      residence: json['residence'],
      phone: json['phone'],
      direction: Direction.fromJson(json['direction']),
      activity: Activity.fromJson(json['activity']),
      collectiveName: json['collectiveName'],
      collectiveCity: json['collectiveCity'],
      ltpriority: json['ltpriority'],
      educationPlace: json['educationPlace'],
      masterName: json['masterName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'birthdate': birthdate!.toIso8601String().split('T')[0],
      // Формат YYYY-MM-DD
      'residence': residence,
      'phone': phone,
      'direction': direction,
      'activity': activity,
      'collectiveName': collectiveName,
      'collectiveCity': collectiveCity,
      'ltpriority': ltpriority,
      'educationPlace': educationPlace,
      'masterName': masterName,
    };
  }
}
