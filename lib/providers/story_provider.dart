import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/providers/user_provider.dart';

import '../data/models/ltstory.dart';
import '../data/services/api_service.dart';
import 'auth_state.dart';

final storyProvider = FutureProvider.family<List<LTStory>, String>(
  (ref, direction) {
    final authStateAsync = ref.watch(authNotifierProvider);

    return authStateAsync.when(
      data: (state) {
        switch (state) {
          case Authenticated():
            return ref
                .read(apiServiceProvider)
                .getLTStoriesByDirection(direction);
          case _:
            return Future.value([]);
        }
      },
      loading: () => Future.value([]),
      error: (e, s) => Future.value([]),
    );
  },
);
