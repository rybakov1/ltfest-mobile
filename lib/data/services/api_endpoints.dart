abstract class ApiEndpoints {
  static const String requestOtp = 'api/request-otp';
  static const String verifyOtp = 'api/verify-otp';
  static const String refreshToken = 'api/refresh-token';
  static const String users = 'api/users/';
  static const String me = 'api/users/me';
  static const String favourites = 'api/favourites/';
  static const String activities = 'api/activities/';
  static const String directions = 'api/directions/';
  static const String festivals = 'api/festivals/';
  static const String laboratories = 'api/laboratories/';
  static const String teachers = 'api/teachers/';
  static const String jury = 'api/jury/';
  static const String upcomingEvents = 'api/upcoming-events/';
  static const String news = 'api/news/';
  static String festivalById(String id) => 'api/festivals/$id';
  static String laboratoryById(String id) => 'api/laboratories/$id';
}