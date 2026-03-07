import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../models/laboratory.dart';
import '../services/api_exception.dart';

final laboratoryRepositoryProvider = Provider<LaboratoryRepository>((ref) {
  return LaboratoryRepository(ref.watch(apiClientProvider));
});

class LaboratoryRepository with ApiErrorHandler {
  final ApiClient _client;

  LaboratoryRepository(this._client);

  Future<List<Laboratory>> getLaboratories() async {
    try {
      final response = await _client.getLaboratories({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, Laboratory.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<Laboratory> getLaboratoryById(String id) async {
    try {
      final response = await _client.getLaboratories({
        'filters[id][\$eq]': id,
        'populate[0]': 'direction',
        'populate[1]': 'learning_types',
        'populate[2]': 'days',
        'populate[3]': 'image',
        'populate[4]': 'persons.image',
        'populate[5]': 'days.laboratory_day_events',
      });
      final list = _parseList(response as Map<String, dynamic>, Laboratory.fromJson);
      if (list.isEmpty) {
        throw ApiException(message: 'Laboratory with id $id not found');
      }
      return list.first;
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<Laboratory>> getLaboratoriesByDirection(String direction) async {
    try {
      final response = await _client.getLaboratories({
        'filters[direction][title][\$eq]': direction,
        'populate': '*',
      });
      return _parseList(response as Map<String, dynamic>, Laboratory.fromJson);
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
