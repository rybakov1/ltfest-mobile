import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/providers/user_provider.dart';
import '../data/models/news.dart';
import 'auth_state.dart';

final newsNotifierProvider = AsyncNotifierProvider<NewsNotifier, List<News>>(
  NewsNotifier.new,
);

class NewsNotifier extends AsyncNotifier<List<News>> {
  @override
  Future<List<News>> build() async {
    final authState = await ref.watch(authNotifierProvider.future);

    if (authState is Authenticated) {
      final apiService = ref.read(apiServiceProvider);
      return apiService.getNews();
    } else {
      return [];
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}
