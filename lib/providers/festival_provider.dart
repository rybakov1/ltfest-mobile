import 'dart:async';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'festival_provider.g.dart';

class FestivalsState {
  final List<Festival> allFestivals;
  final String searchQuery;

  FestivalsState({
    this.allFestivals = const [],
    this.searchQuery = '',
  });

  List<Festival> get filteredFestivals {
    if (searchQuery.isEmpty) {
      return allFestivals;
    }
    return allFestivals
        .where((festival) =>
            festival.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  FestivalsState copyWith({
    List<Festival>? allFestivals,
    String? searchQuery,
  }) {
    return FestivalsState(
      allFestivals: allFestivals ?? this.allFestivals,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

@Riverpod(keepAlive: true)
class FestivalsNotifier extends _$FestivalsNotifier {
  @override
  Future<FestivalsState> build(String category) async {
    final apiService = ref.read(apiServiceProvider);
    final festivals = await apiService.getFestivalsByDirection(category);

    try {
      festivals.sort((a, b) => a.dateStart!.compareTo(b.dateStart!));
    } catch (e) {
      print("Ошибка сортировки фестивалей: $e");
    }

    return FestivalsState(allFestivals: festivals);
  }

  void setSearchQuery(String query) {
    if (state.hasValue) {
      state = AsyncData(state.value!.copyWith(searchQuery: query));
    }
  }
}

final festivalByIdProvider = FutureProvider.family<Festival, String>((ref, id) {
  return ref.read(apiServiceProvider).getFestivalById(id);
});
