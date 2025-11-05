import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/age_category.dart';
import 'package:ltfest/data/services/api_service.dart';

final ageCategoryProvider = FutureProvider.autoDispose<List<AgeCategory>>((ref) {
  return ref.watch(apiServiceProvider).getAgeCategories();
});
