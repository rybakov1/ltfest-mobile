import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/services/api_service.dart';
import '../data/models/news.dart';

final newsNotifierProvider =
    AsyncNotifierProvider<NewsNotifier, List<News>>(NewsNotifier.new);

class NewsNotifier extends AsyncNotifier<List<News>> {
  @override
  Future<List<News>> build() async {
    final apiService = ref.read(apiServiceProvider);
    return apiService.getNews();
  }

  Future<News> getNewsDetails(String id) {
    final apiService = ref.read(apiServiceProvider);
    return apiService.getNewsById(id);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

final newsByIdProvider = FutureProvider.family<News, String>(
  (ref, id) async {
    final api = ref.read(apiServiceProvider);
    try {
      return await api.getNewsById(id);
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  },
);
