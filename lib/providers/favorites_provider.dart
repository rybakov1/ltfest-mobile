import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/favorite.dart';
import 'package:ltfest/data/services/api_service.dart';

enum EventType { festival, laboratory }

// Провайдер для избранных мероприятий
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, AsyncValue<List<Favorite>>>(
  (ref) {
    final apiService = ref.watch(apiServiceProvider);
    return FavoritesNotifier(apiService);
  },
);

class FavoritesNotifier extends StateNotifier<AsyncValue<List<Favorite>>> {
  final ApiService _apiService;
  int? _userId;

  FavoritesNotifier(this._apiService) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final user = await _apiService.getMe();
      _userId = user.id;
      await _fetchFavorites();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> _fetchFavorites() async {
    if (_userId == null) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      state = const AsyncValue.loading();
      final favorites = await _apiService.fetchFavorites();
      state = AsyncValue.data(favorites);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addFavorite(EventType eventType, int eventId) async {
    if (_userId == null) {
      throw Exception('Пользователь не аутентифицирован');
    }

    try {
      await _apiService.addFavorite(eventType.name, eventId);
      await _fetchFavorites(); // Обновляем список избранного
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow; // Пробрасываем ошибку для обработки в UI
    }
  }

  Future<void> removeFavorite(EventType eventType, int eventId) async {
    if (_userId == null) {
      throw Exception('Пользователь не аутентифицирован');
    }

    try {
      await _apiService.removeFavorite(_userId!, eventType.name, eventId);
      await _fetchFavorites(); // Обновляем список избранного
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow; // Пробрасываем ошибку для обработки в UI
    }
  }

  bool isFavorite(EventType eventType, int eventId) {
    if (state is AsyncData<List<Favorite>>) {
      final favorites = (state as AsyncData<List<Favorite>>).value;
      return favorites.any(
        (event) => event.type == eventType.name && event.id == eventId,
      );
    }
    return false;
  }
}

// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../data/models/favorite.dart';
// import '../data/services/api_service.dart';
//
// enum EventType { festival, laboratory }
//
// // Провайдер для избранных мероприятий
// final favoritesProvider =
//     StateNotifierProvider<FavoritesNotifier, AsyncValue<List<Favorite>>>(
//   (ref) {
//     final apiService = ref.watch(apiServiceProvider);
//     return FavoritesNotifier(apiService);
//   },
// );
//
// class FavoritesNotifier extends StateNotifier<AsyncValue<List<Favorite>>> {
//   final ApiService _apiService;
//   int? _userId;
//
//   FavoritesNotifier(this._apiService) : super(const AsyncValue.loading()) {
//     _init();
//   }
//
//   Future<void> _init() async {
//     try {
//       final user = await _apiService.getMe();
//       _userId = user.id;
//       await _fetchFavorites();
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }
//
//   Future<void> _fetchFavorites() async {
//     if (_userId == null) {
//       state = const AsyncValue.data([]);
//       return;
//     }
//
//     try {
//       final favorites = await _apiService.fetchFavorites();
//       state = AsyncValue.data(favorites);
//     } catch (e, stackTrace) {
//       state = AsyncValue.error(e, stackTrace);
//     }
//   }
//
//   Future<void> addFavorite(EventType eventType, int eventId) async {
//     if (_userId == null) throw Exception('Пользователь не аутентифицирован');
//
//     final current = state.asData?.value ?? [];
//     final optimistic = [
//       ...current,
//       Favorite(id: eventId, type: eventType.name, title: '', dateStart: '', dateEnd: ''),
//     ];
//
//     // 👇 Оптимистичное обновление
//     state = AsyncValue.data(optimistic);
//
//     try {
//       await _apiService.addFavorite(eventType.name, eventId);
//     } catch (e, st) {
//       // если ошибка → откат
//       state = AsyncValue.data(current);
//       state = AsyncValue.error(e, st);
//       rethrow;
//     }
//   }
//
//   Future<void> removeFavorite(EventType eventType, int eventId) async {
//     if (_userId == null) throw Exception('Пользователь не аутентифицирован');
//
//     final current = state.asData?.value ?? [];
//     final optimistic =
//     current.where((f) => !(f.type == eventType.name && f.id == eventId)).toList();
//
//     // 👇 Оптимистичное обновление
//     state = AsyncValue.data(optimistic);
//
//     try {
//       await _apiService.removeFavorite(_userId!, eventType.name, eventId);
//     } catch (e, st) {
//       // если ошибка → откат
//       state = AsyncValue.data(current);
//       state = AsyncValue.error(e, st);
//       rethrow;
//     }
//   }
//
//   bool isFavorite(EventType eventType, int eventId) {
//     final favorites = state.asData?.value ?? [];
//     return favorites.any(
//           (event) => event.type == eventType.name && event.id == eventId,
//     );
//   }
// }
