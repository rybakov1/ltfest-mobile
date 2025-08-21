import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/favorite_festival.dart';
import 'package:ltfest/data/models/favorite_laboratory.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/providers/user_provider.dart'; // Импорт authNotifierProvider
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../components/favorite_button.dart';
import '../data/models/upcoming_events.dart' hide EventType;
import '../data/models/user.dart';
import '../data/services/api_service.dart';
import 'auth_state.dart';

part 'favorites_provider.g.dart';

@riverpod
AsyncValue<List<Festival>> favoritesFestivals(Ref ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.when(
    data: (state) {
      return switch (state) {
        Unauthenticated() => const AsyncValue.data([]),
        Authenticated(:final user) =>
          AsyncValue.data(user.favouritesFestivals ?? []),
        NeedsRegistration(:final user) =>
          AsyncValue.data(user.favouritesFestivals ?? []),
        // TODO: Handle this case.
        AuthState() => throw UnimplementedError(),
      };
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
}

@riverpod
AsyncValue<List<Laboratory>> favoritesLabs(Ref ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.when(
    data: (state) {
      return switch (state) {
        Unauthenticated() => const AsyncValue.data([]),
        Authenticated(:final user) =>
          AsyncValue.data(user.favouritesLaboratories ?? []),
        NeedsRegistration(:final user) =>
          AsyncValue.data(user.favouritesLaboratories ?? []),
        // TODO: Handle this case.
        AuthState() => throw UnimplementedError(),
      };
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
}

final favoriteProvider =
StateNotifierProvider<FavoriteNotifier, Set<String>>((ref) {
  return FavoriteNotifier(ref);
});

class FavoriteNotifier extends StateNotifier<Set<String>> {
  final Ref ref;

  FavoriteNotifier(this.ref) : super(_initialFavorites(ref));

  static Set<String> _initialFavorites(Ref ref) {
    final authState = ref.read(authNotifierProvider).value;
    User? user;
    switch (authState) {
      case Authenticated(user: final u):
        user = u;
      case NeedsRegistration(user: final u):
        user = u;
      case Unauthenticated():
        user = null;
    }

    if (user == null) return {};

    final festivalKeys = user.favouritesFestivals
        ?.map((f) => 'festival-${f.id}')
        .toSet() ??
        {};
    final labKeys =
        user.favouritesLaboratories?.map((l) => 'laboratory-${l.id}').toSet() ??
            {};

    return {...festivalKeys, ...labKeys};
  }

  Future<void> toggle(Favoritable event, BuildContext context) async {
    final authState = ref.read(authNotifierProvider).value;

    User? user;
    switch (authState) {
      case Authenticated(user: final u):
        user = u;
      case NeedsRegistration(user: final u):
        user = u;
      case Unauthenticated():
        user = null;
    }

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Нужно войти в систему')),
      );
      return;
    }

    final api = ref.read(apiServiceProvider);
    final key = '${event.favoriteType.name}-${event.favoriteId}';

    if (state.contains(key)) {
      state = {...state}..remove(key);

      if (event.favoriteType == EventType.festival) {
        await api.removeFavoriteFestival(user.id, event.favoriteId);
      } else {
        await api.removeFavoriteLaboratory(user.id, event.favoriteId);
      }
    } else {
      state = {...state, key};

      if (event.favoriteType == EventType.festival) {
        await api.addFavoriteFestival(user.id, event.favoriteId);
      } else {
        await api.addFavoriteLaboratory(user.id, event.favoriteId);
      }
    }
  }

  bool isFavorite(Favoritable event) {
    final key = '${event.favoriteType.name}-${event.favoriteId}';
    return state.contains(key);
  }
}