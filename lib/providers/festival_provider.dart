import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/providers/direction_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 1. Модель состояния для нашего фильтра и поиска
class FestivalsState {
  final List<Festival> allFestivals; // Исходный список, полученный от API
  final String searchQuery;

  FestivalsState({
    this.allFestivals = const [],
    this.searchQuery = '',
  });

  // Геттер, который возвращает отфильтрованный список для отображения в UI
  List<Festival> get filteredFestivals {
    if (searchQuery.isEmpty) {
      return allFestivals;
    }
    // Фильтруем по названию, игнорируя регистр
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

// 2. Наш новый "умный" Notifier
final festivalsProvider =
AsyncNotifierProvider<FestivalsNotifier, FestivalsState>(
    FestivalsNotifier.new);

@Riverpod(keepAlive: true)
class FestivalsNotifier extends AsyncNotifier<FestivalsState> {
  @override
  Future<FestivalsState> build() async {
    // 1. "Слушаем" selectedDirectionProvider. Теперь он может быть null.
    final selectedDirection = ref.watch(selectedDirectionProvider);
    final apiService = ref.read(apiServiceProvider);

    List<Festival> festivals;

    // 2. Логика для загрузки данных
    if (selectedDirection == null) {
      // Если направление не выбрано (null), загружаем ВСЕ фестивали
      festivals = await apiService.getFestivals(); // Предполагаем, что у вас есть такой метод
    } else {
      // Иначе загружаем по конкретному направлению
      festivals = await apiService.getFestivalsByDirection(selectedDirection);
    }

    // 3. СОРТИРОВКА: Сортируем полученный список по дате начала.
    // Сначала самые ранние.
    // Используем try-catch на случай, если у какого-то фестиваля нет даты
    try {
      festivals.sort((a, b) => a.dateStart!.compareTo(b.dateStart!));
    } catch(e) {
      // Можно добавить логирование, если нужно отследить фестивали без даты
      print("Ошибка сортировки фестивалей: $e");
    }

    return FestivalsState(allFestivals: festivals);
  }

  // setSearchQuery остается без изменений
  void setSearchQuery(String query) {
    state = AsyncData(state.value!.copyWith(searchQuery: query));
  }
}

// Провайдер для одного фестиваля (остается без изменений)
final festivalByIdProvider =
FutureProvider.family<Festival, String>((ref, id) {
  return ref.read(apiServiceProvider).getFestivalById(id);
});