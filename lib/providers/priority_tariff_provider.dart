import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/priority_tariff.dart';
import '../data/repositories/festival_repository.dart';

part 'priority_tariff_provider.g.dart';

@riverpod
Future<List<PriorityTariff>> priorityTariffs(Ref ref) {
  final repo = ref.watch(festivalRepositoryProvider);
  return repo.getPriorityTariffs();
}
