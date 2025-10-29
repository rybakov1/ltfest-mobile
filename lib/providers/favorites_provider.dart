import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/favorite.dart';
import 'package:ltfest/data/services/api_service.dart';

enum EventType { festival, laboratory, product }

final favoritesProvider =
AsyncNotifierProvider<FavoritesNotifier, List<Favorite>>(FavoritesNotifier.new);

class FavoritesNotifier extends AsyncNotifier<List<Favorite>> {
  late final ApiService _api;

  @override
  Future<List<Favorite>> build() async {
    _api = ref.read(apiServiceProvider);
    return _api.fetchFavorites();
  }

  Future<void> toggleFavorite(EventType type, int eventId) async {
    final items = state.value;
    if (items == null) return;

    final isFav = items.any((f) => f.type == type.name && f.id == eventId);

    if (isFav) {
      final favoriteToRemove = items.firstWhere(
            (f) => f.type == type.name && f.id == eventId,
      );

      // Оптимистично удаляем
      state = AsyncValue.data(
        items.where((f) => f.favoriteId != favoriteToRemove.favoriteId).toList(),
      );

      try {
        await _api.removeFavorite(favoriteToRemove.favoriteId);
      } catch (e) {
        state = AsyncValue.data(items);
        rethrow;
      }
    } else {
      try {
        await _api.addFavorite(type.name, eventId);

        // Ставим состояние "загрузка", но сохраняем старые данные
        state = const AsyncLoading<List<Favorite>>().copyWithPrevious(state);

        final freshFavorites = await _api.fetchFavorites();
        state = AsyncValue.data(freshFavorites);
      } catch (e) {
        state = AsyncValue.data(items);
        rethrow;
      }
    }
  }

  bool isFavorite(EventType type, int eventId) {
    final items = state.value;
    if (items == null) return false;
    return items.any((f) => f.type == type.name && f.id == eventId);
  }
}
