import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/ltbanner.dart';
import '../data/repositories/content_repository.dart';

final bannerProvider = FutureProvider<List<LTBanner>>((ref) async {
  final repo = ref.watch(contentRepositoryProvider);
  try {
    return await repo.getBanners();
  } catch (e) {
    return [];
  }
});
