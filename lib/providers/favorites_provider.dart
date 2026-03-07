import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/favorite.dart';
import 'package:ltfest/data/repositories/favorites_repository.dart';

enum EventType { festival, laboratory, product }

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<Favorite>>(FavoritesNotifier.new);

class FavoritesNotifier extends AsyncNotifier<List<Favorite>> {
  late final FavoritesRepository _repo;

  @override
  Future<List<Favorite>> build() async {
    _repo = ref.read(favoritesRepositoryProvider);
    return _repo.fetchFavorites();
  }

  Future<void> toggleFavorite(EventType type, int eventId) async {
    final items = state.value;
    if (items == null) return;

    final isFav = items.any((f) => f.type == type.name && f.id == eventId);

    if (isFav) {
      final favoriteToRemove = items.firstWhere(
        (f) => f.type == type.name && f.id == eventId,
      );

      state = AsyncValue.data(
        items.where((f) => f.favoriteId != favoriteToRemove.favoriteId).toList(),
      );

      try {
        await _repo.removeFavorite(favoriteToRemove.favoriteId);
      } catch (e) {
        state = AsyncValue.data(items);
        rethrow;
      }
    } else {
      try {
        await _repo.addFavorite(type.name, eventId);

        state = const AsyncLoading<List<Favorite>>().copyWithPrevious(state);

        final freshFavorites = await _repo.fetchFavorites();
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
