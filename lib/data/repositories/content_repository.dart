import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../models/activity.dart';
import '../models/age_category.dart';
import '../models/direction.dart';
import '../models/ltbanner.dart';
import '../models/ltstory.dart';
import '../models/news.dart';
import '../models/upcoming_events.dart';
import '../services/api_exception.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  return ContentRepository(ref.watch(apiClientProvider));
});

class ContentRepository with ApiErrorHandler {
  final ApiClient _client;

  ContentRepository(this._client);

  // ── News ──

  Future<List<News>> getNews() async {
    try {
      final response = await _client.getNews({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, News.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<News> getNewsById(String id) async {
    try {
      final response = await _client.getNews({
        'filters[id][\$eq]': id,
        'populate': '*',
      });
      final list = _parseList(response as Map<String, dynamic>, News.fromJson);
      if (list.isEmpty) throw ApiException(message: 'News with id $id not found');
      return list.first;
    } catch (e) {
      handleError(e);
    }
  }

  // ── Banners ──

  Future<List<LTBanner>> getBanners() async {
    try {
      final response = await _client.getBanners({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, LTBanner.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  // ── Stories ──

  Future<List<LTStory>> getStories() async {
    try {
      final response = await _client.getStories({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, LTStory.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<LTStory>> getStoriesByDirection(String direction) async {
    try {
      final response = await _client.getStories({
        'filters[direction][title][\$eq]': direction,
        'populate': '*',
      });
      return _parseList(response as Map<String, dynamic>, LTStory.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  // ── Upcoming Events ──

  Future<List<UpcomingEvent>> getUpcomingEvents() async {
    try {
      final response = await _client.getUpcomingEvents({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, UpcomingEvent.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  // ── Activities / Directions / Age Categories ──

  Future<List<Activity>> getActivities() async {
    try {
      final response = await _client.getActivities({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, Activity.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<Direction>> getDirections() async {
    try {
      final response = await _client.getDirections({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, Direction.fromJson);
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<AgeCategory>> getAgeCategories() async {
    try {
      final response = await _client.getAgeCategories({'populate': '*'});
      return _parseList(response as Map<String, dynamic>, AgeCategory.fromJson);
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
