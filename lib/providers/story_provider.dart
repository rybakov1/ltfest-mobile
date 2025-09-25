import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/providers/user_provider.dart';

import '../data/models/ltstory.dart';
import '../data/services/api_service.dart';
import 'auth_state.dart';

final storyProvider = FutureProvider<List<LTStory>>((ref) {
  final authStateAsync = ref.watch(authNotifierProvider);

  return authStateAsync.when(
    data: (state) {
      switch (state) {
        case Authenticated():
          return ref.read(apiServiceProvider).getLTStories();
        case _:
          return [];
      }
    },
    loading: () => [],
    error: (e, s) => [],
  );
});
