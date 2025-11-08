import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/priority_tariff.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ltfest/data/services/api_service.dart';

part 'priority_tariff_provider.g.dart';

@riverpod
Future<List<PriorityTariff>> priorityTariffs(Ref ref) {
  final api = ref.watch(apiServiceProvider);
  return api.getPriorityTariffs();
}
