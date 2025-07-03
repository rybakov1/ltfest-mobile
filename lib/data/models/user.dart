class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime birthdate;
  final String residence;
  final String phone;
  final int directionid;
  final int activityid;
  final String? collectivename;
  final String? collectivecity;
  final int bonuses;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.birthdate,
    required this.residence,
    required this.phone,
    required this.directionid,
    required this.activityid,
    this.collectivename,
    this.collectivecity,
    required this.bonuses,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      birthdate: DateTime.parse(json['birthdate']),
      residence: json['residence'],
      phone: json['phone'],
      directionid: json['directionid'],
      activityid: json['activityid'],
      collectivename: json['collectivename'],
      collectivecity: json['collectivecity'],
      bonuses: json['bonuses'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'birthdate': birthdate.toIso8601String().split('T')[0],  // Формат YYYY-MM-DD
      'residence': residence,
      'phone': phone,
      'directionid': directionid,
      'activityid': activityid,
      'collectivename': collectivename,
      'collectivecity': collectivecity,
      'bonuses': bonuses,
    };
  }
}