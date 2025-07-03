import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/news.dart';
import '../data/services/api_service.dart';

final newsProvider = FutureProvider<List<News>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getNews();
});