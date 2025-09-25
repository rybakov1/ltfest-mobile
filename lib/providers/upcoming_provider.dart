import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/providers/user_provider.dart';

import '../data/models/upcoming_events.dart';
import '../data/services/api_service.dart';
import 'auth_state.dart';

final upcomingEventsProvider = FutureProvider<List<UpcomingEvent>>((ref) {
  final authStateAsync = ref.watch(authNotifierProvider);

  return authStateAsync.when(
    data: (state) {
      switch (state) {
        case Authenticated():
          return ref.read(apiServiceProvider).fetchUpcomingEvents();
        case _:
          return [];
      }
    },
    loading: () => [],
    error: (e, s) => [],
  );
});