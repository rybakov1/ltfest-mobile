import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/festival_tariff.dart';
import '../data/repositories/festival_repository.dart';

part 'festival_tariff_provider.g.dart';

@riverpod
Future<List<FestivalTariff>> festivalTariffs(Ref ref) {
  final repo = ref.watch(festivalRepositoryProvider);
  return repo.getFestivalTariffs();
}

@riverpod
Future<List<FestivalTariff>> tariffsForFestival(Ref ref, int festivalId) {
  final repo = ref.watch(festivalRepositoryProvider);
  return repo.getTariffsForFestival(festivalId);
}
