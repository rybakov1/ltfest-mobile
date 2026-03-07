import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../models/favorite.dart';
import '../services/api_exception.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository(ref.watch(apiClientProvider));
});

class FavoritesRepository with ApiErrorHandler {
  final ApiClient _client;

  FavoritesRepository(this._client);

  Future<List<Favorite>> fetchFavorites() async {
    try {
      final data = await _client.getFavorites();
      return data
          .map((json) => Favorite.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      handleError(e);
    }
  }

  Future<Map<String, dynamic>> addFavorite(String eventType, int eventId) async {
    try {
      return await _client.addFavorite({
        'event_type': eventType,
        'event_id': eventId,
      }) as Map<String, dynamic>;
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> removeFavorite(int favoriteId) async {
    try {
      await _client.removeFavorite(favoriteId);
    } catch (e) {
      handleError(e);
    }
  }
}
