import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/age_category.dart';
import '../data/repositories/content_repository.dart';

final ageCategoryProvider = FutureProvider<List<AgeCategory>>((ref) async {
  final repo = ref.watch(contentRepositoryProvider);
  return repo.getAgeCategories();
});
