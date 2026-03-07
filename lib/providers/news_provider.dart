import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/news.dart';
import '../data/repositories/content_repository.dart';

final newsNotifierProvider =
    AsyncNotifierProvider<NewsNotifier, List<News>>(NewsNotifier.new);

class NewsNotifier extends AsyncNotifier<List<News>> {
  @override
  Future<List<News>> build() async {
    final repo = ref.read(contentRepositoryProvider);
    return repo.getNews();
  }

  Future<News> getNewsDetails(String id) {
    final repo = ref.read(contentRepositoryProvider);
    return repo.getNewsById(id);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

final newsByIdProvider = FutureProvider.family<News, String>(
  (ref, id) async {
    final repo = ref.read(contentRepositoryProvider);
    try {
      return await repo.getNewsById(id);
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  },
);
