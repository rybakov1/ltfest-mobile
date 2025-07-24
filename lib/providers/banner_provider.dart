import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/ltbanner.dart';
import '../data/services/api_service.dart';

final bannerProvider = FutureProvider<LTBanner>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getBanners();
});