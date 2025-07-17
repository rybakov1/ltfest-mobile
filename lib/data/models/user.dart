class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime? birthdate; // Сделаем nullable на случай отсутствия
  final String? residence;   // Сделаем nullable
  final String? phone;       // Сделаем nullable
  final int? directionid;   // Сделаем nullable
  final int? activityid;    // Сделаем nullable
  final String? collectivename;
  final String? collectivecity;
  final String? ltpriority;       // Сделаем nullable

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.birthdate,
    this.residence,
    this.phone,
    this.directionid,
    this.activityid,
    this.collectivename,
    this.collectivecity,
    this.ltpriority,
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
      'directionid': directionid,
      'activityid': activityid,
      'collectivename': collectivename,
      'collectivecity': collectivecity,
      'ltpriority': ltpriority,
    };
  }
}