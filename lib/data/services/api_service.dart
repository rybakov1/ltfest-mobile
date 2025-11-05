import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/age_category.dart';
import 'package:ltfest/data/models/ltstory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../pages/cart/models/cart.dart';
import '../models/favorite.dart';
import '../models/ltbanner.dart';
import '../models/payment.dart';
import '../models/product/product.dart';
import '../models/product/product_details.dart';
import '../models/product/product_in_stock.dart';
import 'dio_provider.dart';
import '../models/news.dart';
import '../models/upcoming_events.dart';
import '../models/user.dart';
import '../models/activity.dart';
import '../models/direction.dart';
import '../models/festival.dart';
import '../models/laboratory.dart';
import 'api_endpoints.dart';
import 'api_exception.dart';
import 'token_storage.dart';

part 'api_service.g.dart';

@riverpod
ApiService apiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return ApiService(dio: dio, tokenStorage: tokenStorage);
}

class ApiService {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  ApiService({required Dio dio, required TokenStorage tokenStorage})
      : _dio = dio,
        _tokenStorage = tokenStorage;

  Never _handleError(Object e) {
    if (e is DioException) {
      debugPrint(e.stackTrace.toString());
      throw ApiException.fromDioError(e);
    }
    debugPrint(e.toString());
    throw ApiException(message: e.toString());
  }

  Future<void> requestOtp(String phone) async {
    try {
      final response =
          await _dio.post(ApiEndpoints.sendOtp, data: {"phone": phone});
      if (response.statusCode != 200) {
        throw ApiException(
            message:
                response.data['error']?['message'] ?? 'Failed to request OTP',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<User> verifyOtp(String phone, String code) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.verifyOtp,
        data: {'phone': phone, 'code': code},
        queryParameters: {'populate': '*'},
      );

      if (response.statusCode == 200) {
        final jwt = response.data['jwt'] as String?;
        final userData = response.data['user'] as Map<String, dynamic>?;
        if (jwt == null || userData == null) {
          throw ApiException(
              message: 'Invalid response: Missing jwt or user data');
        }
        await _tokenStorage.saveToken(jwt: jwt);
        return User.fromJson(userData);
      } else {
        throw ApiException(
            message:
                response.data['error']?['message'] ?? 'Failed to verify OTP');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<User> getMe() async {
    try {
      final response = await _dio.get(ApiEndpoints.me, queryParameters: {
        'populate[0]': 'direction',
        'populate[1]': 'activity',
        'populate[2]': 'age_category',
      });
      return User.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<User> updateProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String email,
    required String birthDate,
    required String residence,
    int? directionId,
    int? activityId,
    int? ageCategoryId,
    int? count_participant,
    String? collectiveName,
    String? collectiveCity,
    String? educationPlace,
    String? masterName,
  }) async {
    try {
      final endpoint = ApiEndpoints.userById(userId);

      final data = {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'birthdate': birthDate,
        'residence': residence,
        'direction': directionId,
        'activity': activityId,
        'collectiveName': collectiveName,
        'collectiveCity': collectiveCity,
        'educationPlace': educationPlace,
        'count_participant': count_participant,
        'age_category': ageCategoryId,
        'masterName': masterName,
      };

      final response = await _dio.put(endpoint, data: data);

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw ApiException(
            message: 'Failed to update user profile',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<T>> _fetchCollection<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: {'populate': '*'});
      final List<dynamic> data = response.data['data'];
      return data
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<T> _fetchOne<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson,
      {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);
      return fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<Activity>> getActivities() =>
      _fetchCollection(ApiEndpoints.activities, Activity.fromJson);

  Future<List<Direction>> getDirections() =>
      _fetchCollection(ApiEndpoints.directions, Direction.fromJson);

  Future<List<AgeCategory>> getAgeCategories() =>
      _fetchCollection(ApiEndpoints.ageCategory, AgeCategory.fromJson);

  Future<List<Festival>> getFestivals() =>
      _fetchCollection(ApiEndpoints.festivals, Festival.fromJson);

  Future<List<LTStory>> getLTStories() =>
      _fetchCollection(ApiEndpoints.stories, LTStory.fromJson);

  Future<List<Laboratory>> getLaboratories() =>
      _fetchCollection(ApiEndpoints.laboratories, Laboratory.fromJson);

  Future<List<LTBanner>> getBanners() =>
      _fetchCollection(ApiEndpoints.banners, LTBanner.fromJson);

  Future<List<News>> getNews() =>
      _fetchCollection(ApiEndpoints.news, News.fromJson);

  Future<List<UpcomingEvent>> fetchUpcomingEvents() =>
      _fetchCollection(ApiEndpoints.upcomingEvents, UpcomingEvent.fromJson);

  // Future<List<Favorite>> fetchFavorites() =>
  //     _fetchCollection(ApiEndpoints.favorites, Favorite.fromJson);

  Future<List<Favorite>> fetchFavorites() async {
    try {
      final response = await _dio.get(ApiEndpoints.favorites);
      final List<dynamic> data = response.data;
      return data
          .map((json) => Favorite.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<Festival> getFestivalById(String id) async {
    try {
      // FIX: Add the populate parameters back in using queryParameters
      final response = await _dio.get(
        ApiEndpoints.festivals, // Use the base endpoint for lists
        queryParameters: {
          'filters[id][\$eq]': id,
          'populate[0]': 'direction',
          'populate[1]': 'persons.image',
          'populate[2]': 'image',
        },
      );

      final List<dynamic> dataList = response.data['data'];
      if (dataList.isEmpty) {
        throw ApiException(message: 'Festival with id $id not found');
      }
      return Festival.fromJson(dataList.first as Map<String, dynamic>);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<Laboratory> getLaboratoryById(String id) async {
    try {
      // FIX: Add the populate parameters back in using queryParameters
      final response = await _dio.get(
        ApiEndpoints.laboratories, // Use the base endpoint for lists
        queryParameters: {
          'filters[id][\$eq]': id,
          'populate[0]': 'direction',
          'populate[1]': 'learning_types',
          'populate[2]': 'days',
          'populate[3]': 'image',
          'populate[4]': 'persons.image',
          'populate[5]': 'days.laboratory_day_events',
        },
      );

      final List<dynamic> dataList = response.data['data'];
      if (dataList.isEmpty) {
        throw ApiException(message: 'Laboratory with id $id not found');
      }
      return Laboratory.fromJson(dataList.first as Map<String, dynamic>);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<News> getNewsById(String id) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.news, // Use the base endpoint for lists
        queryParameters: {
          'filters[id][\$eq]': id,
          'populate': '*', // Or list specific fields if you know them
        },
      );

      final List<dynamic> dataList = response.data['data'];
      if (dataList.isEmpty) {
        throw ApiException(message: 'News with id $id not found');
      }
      return News.fromJson(dataList.first as Map<String, dynamic>);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<LTStory>> getLTStoriesByDirection(String direction) async {
    try {
      final response = await _dio.get(ApiEndpoints.stories,
          queryParameters: {
            'filters[direction][title][\$eq]': direction,
            'populate': '*'
          });
      final List<dynamic> data = response.data['data'];
      return data.map((json) => LTStory.fromJson(json)).toList();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<Laboratory>> getLaboratoriesByDirection(String direction) async {
    try {
      final response = await _dio.get(ApiEndpoints.laboratories,
          queryParameters: {
            'filters[direction][title][\$eq]': direction,
            'populate': '*'
          });
      final List<dynamic> data = response.data['data'];
      return data.map((json) => Laboratory.fromJson(json)).toList();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<Festival>> getFestivalsByDirection(String direction) async {
    try {
      final response = await _dio.get(ApiEndpoints.festivals, queryParameters: {
        'filters[direction][title][\$eq]': direction,
        'populate': '*'
      });
      final List<dynamic> data = response.data['data'];
      return data.map((json) => Festival.fromJson(json)).toList();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<Map<String, dynamic>> addFavorite(String eventType, int eventId) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.favorites,
        data: {
          'event_type': eventType,
          'event_id': eventId,
        },
      );
      // Просто возвращаем сырой JSON-ответ. Notifier разберется.
      return response.data as Map<String, dynamic>;
    } catch (e) {
      _handleError(e);
    }
  }


// --- ЭТОТ МЕТОД ОСТАЕТСЯ ВЕРНЫМ ---
// Он принимает ID самого "избранного" и передает его в URL, что правильно для вашего бэкенда.
  Future<void> removeFavorite(int favoriteId) async {
    try {
      await _dio.delete('${ApiEndpoints.favorites}/$favoriteId');
    } catch (e) {
      _handleError(e);
    }
  }

//   Future<void> addFavorite(String eventType, int eventId) async {
//     if (!['festival', 'laboratory'].contains(eventType)) {
//       throw ApiException(message: 'Invalid event_type: $eventType');
//     }
//
//     try {
//       final response = await _dio.post(
//         ApiEndpoints.favorites,
//         data: {
//           'event_type': eventType,
//           'event_id': eventId,
//         },
//       );
//
//       if (response.statusCode != 200) {
//         throw ApiException(
//           message:
//               'Failed to add favorite $eventType: ${response.statusMessage}',
//           statusCode: response.statusCode,
//         );
//       }
//     } catch (e) {
//       _handleError(e);
//     }
//   }
//
// // Удаление мероприятия из избранного
//   Future<void> removeFavorite(int userId, String eventType, int eventId) async {
//     if (!['festival', 'laboratory'].contains(eventType)) {
//       throw ApiException(message: 'Invalid event_type: $eventType');
//     }
//
//     try {
//       // Находим запись в Favorites
//       final response = await _dio.get(
//         ApiEndpoints.favorites,
//         queryParameters: {
//           'filters[users_permissions_user][id][\$eq]': userId,
//           'filters[event_type][\$eq]': eventType,
//           'filters[event_id][\$eq]': eventId,
//         },
//       );
//
//       print("$eventType/$eventId/$userId/$response");
//
//       if (response.statusCode != 200) {
//         throw ApiException(
//           message:
//               'Failed to find favorite $eventType: ${response.statusMessage}',
//           statusCode: response.statusCode,
//         );
//       }
//
//       print("api response: ${response.data}");
//
//       final data = response.data as List<dynamic>;
//       if (data.isEmpty) {
//         throw ApiException(message: 'Favorite $eventType not found');
//       }
//
//       print(data[0].toString());
//       final favoriteId = int.parse(data[0]['favoriteId'].toString());
//       print(favoriteId);
//
//       //Удаляем запись
//       final deleteResponse =
//           await _dio.delete(ApiEndpoints.favoriteById(favoriteId));
//
//       if (deleteResponse.statusCode != 200) {
//         throw ApiException(
//           message:
//               'Failed to remove favorite $eventType: ${deleteResponse.statusMessage}',
//           statusCode: deleteResponse.statusCode,
//         );
//       }
//     } catch (e) {
//       _handleError(e);
//     }
//   }

  // --- SHOP & CART ---

  Future<List<ProductInStock>> getAllVariations() async {
    try {
      final response = await _dio.get(ApiEndpoints.productInStocks,
          queryParameters: {'populate': '*'});
      final List<dynamic> data = response.data['data'];
      return data
          .map((json) => ProductInStock.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<Product>> getProductsForCatalog() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.products,
        queryParameters: {
          'populate[0]': 'product_in_stocks',
          'populate[1]': 'product_in_stocks.product_color',
          'populate[2]': 'product_in_stocks.product_size',
          'populate[3]': 'product_in_stocks.images',
          'populate[4]': 'product_materials',
        },
      );
      final List<dynamic> data = response.data['data'];
      return data
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<Product> getProductDetailsById(String id) async {
    try {
      final response = await _dio.get(
        // Используем общий эндпоинт, чтобы добавить фильтры и populate
        ApiEndpoints.products,
        queryParameters: {
          'filters[id][\$eq]': id,
          'populate[0]': 'product_in_stocks',
          'populate[1]': 'product_in_stocks.product_color',
          'populate[2]': 'product_in_stocks.product_size',
          'populate[3]': 'product_in_stocks.images',
          'populate[4]': 'product_materials',
        },
      );

      final List<dynamic> dataList = response.data['data'];
      if (dataList.isEmpty) {
        throw ApiException(message: 'Product with id $id not found');
      }
      // Парсим первый (и единственный) элемент из полученного массива
      return Product.fromJson(dataList.first as Map<String, dynamic>);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Получает корзину текущего пользователя.
  Future<Cart> getMyCart() async {
    try {
      return _fetchOne(ApiEndpoints.myCart, Cart.fromJson,
          query: {'populate': '*'});
    } catch (e) {
      _handleError(e);
    }
  }

  /// Добавляет товар (вариацию) в корзину.
  Future<void> addToCart(
      {required int productInStockId, int quantity = 1}) async {
    try {
      await _dio.post(ApiEndpoints.cartItems, data: {
        'data': {'product_in_stock': productInStockId, 'quantity': quantity}
      });
    } catch (e) {
      _handleError(e);
    }
  }

  /// Обновляет количество товара в корзине.
  Future<void> updateCartItemQuantity(
      {required int cartItemId, required int newQuantity}) async {
    try {
      await _dio.put('${ApiEndpoints.cartItems}/$cartItemId',
          data: {'quantity': newQuantity});
    } catch (e) {
      _handleError(e);
    }
  }

  /// Удаляет товар из корзины.
  Future<void> removeCartItem({required int cartItemId}) async {
    try {
      await _dio.delete('${ApiEndpoints.cartItems}/$cartItemId');
    } catch (e) {
      _handleError(e);
    }
  }

  Future<PaymentInitResponse> initPayment({
    required int amount,
    required String orderId,
    required String successUrl,
    required String failUrl,
    String description = 'Оплата',
    String? customerEmail,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paymentsInit,
        data: {
          'amount': amount,
          'orderId': orderId,
          'successUrl': successUrl,
          'failUrl': failUrl,
          'description': description,
          'customerEmail': customerEmail,
        },
      );
      return PaymentInitResponse.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<PaymentStateResponse> getPaymentState(String paymentId) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paymentsState,
        data: {'paymentId': paymentId},
      );
      return PaymentStateResponse.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<PaymentStateResponse> confirmPayment(String paymentId) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paymentsConfirm,
        data: {'paymentId': paymentId},
      );
      return PaymentStateResponse.fromJson(response.data);
    } catch (e) {
      _handleError(e);
    }
  }

  String getImageUrl(String? relativeUrl) {
    if (relativeUrl == null || relativeUrl.isEmpty) {
      return '';
    }
    return '${_dio.options.baseUrl}$relativeUrl';
  }
}
