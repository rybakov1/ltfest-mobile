import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/providers/user_provider.dart';

import '../data/models/ltstory.dart';
import '../data/services/api_service.dart';
import 'auth_state.dart';

final storyProvider = FutureProvider<List<LTStory>>((ref) {
  // 1. "Слушаем" authNotifierProvider
  final authStateAsync = ref.watch(authNotifierProvider);

  // 2. Делаем запрос ТОЛЬКО когда authStateAsync перейдет в состояние `data`
  //    и внутри этого `data` будет `Authenticated` или `NeedsRegistration`.
  return authStateAsync.when(
    data: (state) {
      switch (state) {
      // ЕСЛИ пользователь вошел:
        case Authenticated() || NeedsRegistration():
        // ТОЛЬКО ТОГДА делаем запрос к API
          return ref.read(apiServiceProvider).getLTStories();
      // ЕСЛИ пользователь НЕ вошел:
        case _:
        // НЕ ДЕЛАЕМ ЗАПРОС, просто возвращаем пустой список.
          return [];
      }
    },
    // Пока идет проверка аутентификации, запроса тоже нет.
    loading: () => [],
    // Если при проверке аутентификации произошла ошибка, запроса тоже нет.
    error: (e, s) => [],
  );
});