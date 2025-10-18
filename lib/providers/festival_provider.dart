import 'dart:async';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'festival_provider.g.dart';

class FestivalsState {
  final List<Festival> allFestivals;
  final String searchQuery;
  final List<String> selectedCities;
  final bool isRefreshing;

  const FestivalsState({
    this.allFestivals = const [],
    this.searchQuery = '',
    this.selectedCities = const [],
    this.isRefreshing = false,
  });

  Set<String> get uniqueCities {
    return allFestivals
        .map((f) => f.address?.split(',').first.trim() ?? '')
        .where((c) => c.isNotEmpty)
        .toSet()
      ..toList()
      .sort();
  }

  List<Festival> get filteredFestivals {
    return allFestivals.where((festival) {
      final titleMatch = searchQuery.isEmpty ||
          festival.title.toLowerCase().contains(searchQuery.toLowerCase());
      final addressMatch = selectedCities.isEmpty ||
          selectedCities.any((city) =>
          festival.address?.toLowerCase().contains(city.toLowerCase()) ??
              false);
      return titleMatch && addressMatch;
    }).toList();
  }

  FestivalsState copyWith({
    List<Festival>? allFestivals,
    String? searchQuery,
    List<String>? selectedCities,
    bool? isRefreshing,
  }) {
    return FestivalsState(
      allFestivals: allFestivals ?? this.allFestivals,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCities: selectedCities ?? this.selectedCities,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

@Riverpod(keepAlive: true)
class FestivalsNotifier extends _$FestivalsNotifier {
  ApiService get _api => ref.read(apiServiceProvider);
  String? _category;

  @override
  Future<FestivalsState> build([String? category]) async {
    _category = category;

    return _fetchFestivals(category);
  }

  Future<FestivalsState> _fetchFestivals(String? category) async {
    try {
      List<Festival> festivals;

      if (category == null || category.isEmpty) {
        festivals = await _api.getFestivals();
      } else {
        festivals = await _api.getFestivalsByDirection(category);
      }

      festivals.sort((a, b) {
        final aDate = a.dateStart ?? DateTime(2100);
        final bDate = b.dateStart ?? DateTime(2100);
        return aDate.compareTo(bDate);
      });

      return FestivalsState(allFestivals: festivals);
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  }

  Future<void> refresh() async {
    if (state.isLoading) return;

    final prev = state.valueOrNull;
    if (prev == null) return;

    state = AsyncData(prev.copyWith(isRefreshing: true));

    final result = await AsyncValue.guard(() => _fetchFestivals(_category));

    state = result.whenData((data) => data.copyWith(
      searchQuery: prev.searchQuery,
      selectedCities: prev.selectedCities,
      isRefreshing: false,
    ));
  }

  void setSearchQuery(String query) {
    final prev = state.valueOrNull;
    if (prev == null) return;
    state = AsyncData(prev.copyWith(searchQuery: query));
  }

  void setSelectedCities(List<String> cities) {
    final prev = state.valueOrNull;
    if (prev == null) return;
    state = AsyncData(prev.copyWith(selectedCities: cities));
  }
}

final festivalByIdProvider =
FutureProvider.family<Festival, String>((ref, id) async {
  final api = ref.read(apiServiceProvider);
  try {
    return await api.getFestivalById(id);
  } catch (e, st) {
    Error.throwWithStackTrace(e, st);
  }
});