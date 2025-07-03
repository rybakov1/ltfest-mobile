import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/upcoming_events.dart';
import '../data/services/api_service.dart';

final upcomingEventsProvider = FutureProvider<List<UpcomingEvent>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchUpcomingEvents();
});