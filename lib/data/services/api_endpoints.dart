abstract class ApiEndpoints {
  static const String sendOtp = '/api/otp/send';
  static const String verifyOtp = '/api/otp/verify';
  static const String users = '/api/users';
  static const String me = '/api/users/me';

  static String userById(int id) => '/api/users/$id';
  static const String favorites = '/api/favorites';

  static String favoriteById(int id) => '/api/favorites/$id';

  static const String products = '/api/products';
  static const String productInStocks = '/api/product-in-stocks';
  static const String myCart = '/api/carts/me';
  static const String cartItems = '/api/cart-items';
  static const String activities = '/api/activities';
  static const String directions = '/api/directions';
  static const String ageCategory = '/api/age-categories';
  static const String festivals = '/api/festivals';
  static const String festivalTariffs = '/api/festival-tariffs';
  static const String priorityTariffs = '/api/priority-tariffs';

  static const String laboratories = '/api/laboratories';
  static const String upcomingEvents = '/api/upcoming-events';
  static const String news = '/api/news';
  static const String banners = '/api/banners';
  static const String stories = '/api/stories';

  static String productById(String id) => '/api/products?filters[id][\$eq]=$id';

  static String newsById(String id) => '/api/news?filters[id][\$eq]=$id';

  static String festivalById(String id) =>
      '/api/festivals?filters[id][\$eq]=$id';

  static String laboratoryById(String id) =>
      '/api/laboratories?filters[id][\$eq]=$id';

  static String festivalsByDirection(String direction) =>
      '/api/festivals?filters[direction][title][\$eq]=$direction';

  static String laboratoriesByDirection(String direction) =>
      '/api/laboratories?filters[direction][title][\$eq]=$direction';

  static String storiesByDirection(String direction) =>
      '/api/stories?filters[direction][title][\$eq]=$direction';

  static const String orders = '/api/orders';

  static const String paymentsInit = '/api/payments/init';
  static const String paymentsState = '/api/payments/state';
  static const String paymentsConfirm = '/api/payments/confirm';

  static const String promoCodes = '/api/promocodes';
  static const String loyaltyCards = '/api/loyalty-cards';
  static const String accountDeletionRequests = '/api/account-deletion-requests';

  static const String baseStrapiUrl = 'http://37.46.132.144:1337';
}
