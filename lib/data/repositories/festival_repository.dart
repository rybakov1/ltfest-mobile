import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../models/festival.dart';
import '../models/festival_tariff.dart';
import '../models/priority_tariff.dart';
import '../services/api_exception.dart';

final festivalRepositoryProvider = Provider<FestivalRepository>((ref) {
  return FestivalRepository(ref.watch(apiClientProvider));
});

class FestivalRepository with ApiErrorHandler {
  final ApiClient _client;

  FestivalRepository(this._client);

  Future<List<Festival>> getFestivals() async {
    try {
      final response = await _client.getFestivals({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, Festival.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<Festival> getFestivalById(String id) async {
    try {
      final response = await _client.getFestivals({
        'filters[id][\$eq]': id,
        'populate[0]': 'direction',
        'populate[1]': 'persons.image',
        'populate[2]': 'image',
      });
      final list = _parseList(response as Map<String, dynamic>, Festival.fromJson);
      if (list.isEmpty) throw ApiException(message: 'Festival with id $id not found');
      return list.first;
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<Festival>> getFestivalsByDirection(String direction) async {
    try {
      final response = await _client.getFestivals({
        'filters[direction][title][\$eq]': direction,
        'populate': '*',
      });
      return _parseList(response as Map<String, dynamic>, Festival.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<FestivalTariff>> getTariffsForFestival(int festivalId) async {
    try {
      final response = await _client.getFestivalTariffs({
        'filters[festivals][id][\$eq]': festivalId,
        'populate': 'feature',
      });
      return _parseList(response as Map<String, dynamic>, FestivalTariff.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<FestivalTariff>> getFestivalTariffs() async {
    try {
      final response = await _client.getFestivalTariffs({
        'populate[0]': 'festival',
        'populate[1]': 'feature',
      });
      return _parseList(response as Map<String, dynamic>, FestivalTariff.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<PriorityTariff>> getPriorityTariffs() async {
    try {
      final response = await _client.getPriorityTariffs({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, PriorityTariff.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  List<T> _parseList<T>(
    Map<String, dynamic> response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final List<dynamic> data = response['data'];
    return data.map((json) => fromJson(json as Map<String, dynamic>)).toList();
  }
}
