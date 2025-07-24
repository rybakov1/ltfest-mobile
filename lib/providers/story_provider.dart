import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/ltstory.dart';
import '../data/services/api_service.dart';

final storyProvider = FutureProvider<List<LTStory>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getLTStories();
});