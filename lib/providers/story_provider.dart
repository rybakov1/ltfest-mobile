import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/ltstory.dart';
import '../data/repositories/content_repository.dart';

final storyProvider = FutureProvider.family<List<LTStory>, String>(
  (ref, direction) async {
    final repo = ref.watch(contentRepositoryProvider);
    try {
      return await repo.getStoriesByDirection(direction);
    } catch (e) {
      return [];
    }
  },
);
