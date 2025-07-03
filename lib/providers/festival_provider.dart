import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/festival.dart';
import '../data/services/api_service.dart';

final festivalByIdProvider = FutureProvider.family<Festival, String>((ref, id) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getFestivalById(id);
});