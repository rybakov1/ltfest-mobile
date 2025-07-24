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
  static const String banners = '/api/banners';
  static const String stories = '/api/stories';

  static String newsById(String id) => '/api/news?filters[id][\$eq]=$id';

  static String festivalById(String id) =>
      '/api/festivals?filters[id][\$eq]=$id&populate[0]=direction&populate[1]=persons.image&populate[2]=image';

  static String laboratoryById(String id) =>
      '/api/laboratories?filters[id][\$eq]=$id&populate[0]=direction&populate[1]=learning_types&populate[2]=days&populate[3]=image&populate[4]=persons.image';

  static String festivalsByDirection(String direction) =>
      '/api/festivals?filters[direction][title][\$eq]=$direction';

  static String laboratoriesByDirection(String direction) =>
      '/api/laboratories?filters[direction][title][\$eq]=$direction';

  static String userById(int id) => '/api/users/$id';
}
