abstract class ApiEndpoints {
  static const String sendOtp = '/api/otp/send';
  static const String verifyOtp = '/api/otp/verify';

  static const String users = '/api/users';
  static const String me = '/api/users/me';

  static const String favourites = '/api/favourites';
  static const String activities = '/api/activities';
  static const String directions = '/api/directions';
  static const String festivals = '/api/festivals';
  static const String laboratories = '/api/laboratories';
  static const String upcomingEvents = '/api/upcoming-events';
  static const String news = '/api/news';

  static String festivalById(String id) => '/api/festivals?filters[id][\$eq]=$id';
  static String newsById(String id) => '/api/news?filters[id][\$eq]=$id';
  static String laboratoryById(String id) => '/api/laboratories?filters[id][\$eq]=$id';
  static String userById(int id) => '/api/users/$id';
}