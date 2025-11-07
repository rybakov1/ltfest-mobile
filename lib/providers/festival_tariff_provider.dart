import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ltfest/data/models/festival_tariff.dart';
import 'package:ltfest/data/services/api_service.dart';

part 'festival_tariff_provider.g.dart';

@riverpod
Future<List<FestivalTariff>> festivalTariffs(Ref ref) {
  final api = ref.watch(apiServiceProvider);
  return api.getFestivalTariffs();
}

@riverpod
Future<List<FestivalTariff>> tariffsForFestival(Ref ref, int festivalId) {
  final api = ref.watch(apiServiceProvider);
  return api.getTariffsForFestival(festivalId);
}