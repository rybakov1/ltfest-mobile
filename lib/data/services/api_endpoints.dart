//fast api

// abstract class ApiEndpoints {
//   static const String requestOtp = 'api/request-otp';
//   static const String verifyOtp = 'api/verify-otp';
//   static const String refreshToken = 'api/refresh-token';
//   static const String users = 'api/users/';
//   static const String me = 'api/users/me';
//   static const String favourites = 'api/favourites/';
//   static const String activities = 'api/activities/';
//   static const String directions = 'api/directions/';
//   static const String festivals = 'api/festivals/';
//   static const String laboratories = 'api/laboratories/';
//   static const String teachers = 'api/teachers/';
//   static const String jury = 'api/jury/';
//   static const String upcomingEvents = 'api/upcoming-events/';
//   static const String news = 'api/news/';
//   static String festivalById(String id) => 'api/festivals/$id';
//   static String laboratoryById(String id) => 'api/laboratories/$id';
// }


//stapi

abstract class ApiEndpoints {
  // --- АУТЕНТИФИКАЦИЯ (из нашего кастомного контроллера) ---
  static const String requestOtp = '/api/auth/phone-login';
  static const String verifyOtp = '/api/auth/phone-verify';
  // refreshToken в базовой настройке Strapi не используется, его можно убрать

  // --- ПОЛЬЗОВАТЕЛИ ---
  static const String users = '/api/users';
  static const String me = '/api/users/me'; // Этот эндпоинт для получения данных о себе
  // Для обновления пользователя нужен его ID, например: /api/users/123

  // --- КОЛЛЕКЦИИ ---
  // Названия должны совпадать с "API ID (Plural)" в Content-Type Builder Strapi
  static const String favourites = '/api/favourites'; // Убедитесь, что у вас есть такая коллекция
  static const String activities = '/api/activities';
  static const String directions = '/api/directions';
  static const String festivals = '/api/festivals';
  static const String laboratories = '/api/laboratories';
  static const String teachers = '/api/teachers';
  static const String jury = '/api/juries'; // Strapi обычно делает 'y' -> 'ies'
  static const String upcomingEvents = '/api/upcoming-events';
  static const String news = '/api/news';

  // Функции для получения по ID остаются такими же, только пути меняются
  static String festivalById(String id) => '/api/festivals/$id';
  static String laboratoryById(String id) => '/api/laboratories/$id';
  static String userById(int id) => '/api/users/$id';
}