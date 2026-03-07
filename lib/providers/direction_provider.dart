import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/direction.dart';
import '../data/repositories/content_repository.dart';

final selectedDirectionProvider = StateProvider<String?>((ref) => null);

final directionsProvider = FutureProvider<List<Direction>>((ref) async {
  final repo = ref.watch(contentRepositoryProvider);
  return repo.getDirections();
});
