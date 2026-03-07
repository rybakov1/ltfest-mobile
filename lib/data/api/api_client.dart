import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../services/dio_provider.dart';

part 'api_client.g.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  // ── Auth ──

  @POST('/api/otp/send')
  Future<void> requestOtp(@Body() Map<String, Object?> body);

  @POST('/api/otp/verify')
  Future<Map<String, Object?>> verifyOtp(
    @Body() Map<String, Object?> body,
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/users/me')
  Future<Map<String, Object?>> getMe(
    @Queries() Map<String, Object?> queries,
  );

  @PUT('/api/users/{id}')
  Future<Map<String, Object?>> updateUser(
    @Path('id') int id,
    @Body() Map<String, Object?> body,
  );

  // ── Festivals ──

  @GET('/api/festivals')
  Future<Map<String, Object?>> getFestivals(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/festival-tariffs')
  Future<Map<String, Object?>> getFestivalTariffs(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/priority-tariffs')
  Future<Map<String, Object?>> getPriorityTariffs(
    @Queries() Map<String, Object?> queries,
  );

  // ── Laboratories ──

  @GET('/api/laboratories')
  Future<Map<String, Object?>> getLaboratories(
    @Queries() Map<String, Object?> queries,
  );

  // ── News ──

  @GET('/api/news')
  Future<Map<String, Object?>> getNews(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/banners')
  Future<Map<String, Object?>> getBanners(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/stories')
  Future<Map<String, Object?>> getStories(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/upcoming-events')
  Future<Map<String, Object?>> getUpcomingEvents(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/activities')
  Future<Map<String, Object?>> getActivities(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/directions')
  Future<Map<String, Object?>> getDirections(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/age-categories')
  Future<Map<String, Object?>> getAgeCategories(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/products')
  Future<HttpResponse<Map<String, dynamic>>> getProducts(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/product-in-stocks')
  Future<HttpResponse<Map<String, dynamic>>> getProductInStocks(
    @Queries() Map<String, Object?> queries,
  );

  @PUT('/api/product-in-stocks/{documentId}')
  Future<HttpResponse<Map<String, dynamic>>> updateProductInStock(
    @Path('documentId') String documentId,
    @Body() Map<String, Object?> body,
  );

  @GET('/api/favorites')
  Future<List<Object?>> getFavorites();

  @POST('/api/favorites')
  Future<Map<String, Object?>> addFavorite(
    @Body() Map<String, Object?> body,
  );

  @DELETE('/api/favorites/{id}')
  Future<void> removeFavorite(@Path('id') int id);

  @GET('/api/carts/me')
  Future<Map<String, Object?>> getMyCart(
    @Queries() Map<String, Object?> queries,
  );

  @POST('/api/cart-items')
  Future<void> addCartItem(@Body() Map<String, Object?> body);

  @PUT('/api/cart-items/{id}')
  Future<void> updateCartItem(
    @Path('id') int id,
    @Body() Map<String, Object?> body,
  );

  @DELETE('/api/cart-items/{id}')
  Future<void> removeCartItem(@Path('id') int id);

  @GET('/api/orders')
  Future<Map<String, Object?>> getOrders(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/orders/{id}')
  Future<Map<String, Object?>> getOrderById(
    @Path('id') String id,
    @Queries() Map<String, Object?> queries,
  );

  @POST('/api/orders')
  Future<Map<String, Object?>> createOrder(
    @Body() Map<String, Object?> body,
  );

  @PUT('/api/orders/{id}')
  Future<Map<String, Object?>> updateOrder(
    @Path('id') String id,
    @Body() Map<String, Object?> body,
  );

  @POST('/api/payments/init')
  Future<Map<String, Object?>> initPayment(
    @Body() Map<String, Object?> body,
  );

  @POST('/api/payments/state')
  Future<Map<String, Object?>> getPaymentState(
    @Body() Map<String, Object?> body,
  );

  @POST('/api/payments/confirm')
  Future<Map<String, Object?>> confirmPayment(
    @Body() Map<String, Object?> body,
  );

  @GET('/api/promocodes')
  Future<Map<String, Object?>> getPromoCodes(
    @Queries() Map<String, Object?> queries,
  );

  @GET('/api/promocodes/{id}')
  Future<Map<String, Object?>> getPromoCodeById(@Path('id') int id);

  @PUT('/api/promocodes/{documentId}')
  Future<Map<String, Object?>> updatePromoCode(
    @Path('documentId') String documentId,
    @Body() Map<String, Object?> body,
  );

  @GET('/api/loyalty-cards')
  Future<Map<String, Object?>> getLoyaltyCards(
    @Queries() Map<String, Object?> queries,
  );

  @POST('/api/account-deletion-requests')
  Future<void> createAccountDeletionRequest(
    @Body() Map<String, Object?> body,
  );

  @POST('/api/support-messages')
  Future<void> sendSupportMessage(@Body() Map<String, Object?> body);

  @POST('/api/upload')
  Future<List<Object?>> uploadFile(@Body() FormData body);

  @POST('/api/push-tokens')
  Future<HttpResponse<dynamic>> registerPushToken(
    @Body() Map<String, Object?> body,
  );
}
