import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/direction.dart';
import 'package:ltfest/data/services/api_service.dart';

final directionsProvider = FutureProvider.autoDispose<List<Direction>>((ref) {
  return ref.watch(apiServiceProvider).getDirections();
});

final selectedDirectionProvider = StateProvider<String?>((ref) => null);

