import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/upcoming_events.dart';
import '../data/repositories/content_repository.dart';

final upcomingEventsProvider = FutureProvider<List<UpcomingEvent>>((ref) async {
  final repo = ref.watch(contentRepositoryProvider);
  try {
    return await repo.getUpcomingEvents();
  } catch (e) {
    return [];
  }
});
