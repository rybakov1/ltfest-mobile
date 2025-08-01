import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:ltfest/providers/direction_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 1. Модель состояния
class LaboratoriesState {
  final List<Laboratory> allLaboratories;
  final String searchQuery;

  LaboratoriesState({
    this.allLaboratories = const [],
    this.searchQuery = '',
  });

  List<Laboratory> get filteredLaboratories {
    if (searchQuery.isEmpty) {
      return allLaboratories;
    }
    return allLaboratories
        .where((lab) =>
        lab.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  LaboratoriesState copyWith({
    List<Laboratory>? allLaboratories,
    String? searchQuery,
  }) {
    return LaboratoriesState(
      allLaboratories: allLaboratories ?? this.allLaboratories,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

// 2. Notifier
final laboratoriesProvider =
AsyncNotifierProvider<LaboratoriesNotifier, LaboratoriesState>(
    LaboratoriesNotifier.new);

@Riverpod(keepAlive: true)
class LaboratoriesNotifier extends AsyncNotifier<LaboratoriesState> {
  @override
  Future<LaboratoriesState> build() async {
    final selectedDirection = ref.watch(selectedDirectionProvider);
    final apiService = ref.read(apiServiceProvider);

    List<Laboratory> laboratories;

    if (selectedDirection == null) {
      laboratories = await apiService.getLaboratories();
    } else {
      laboratories = await apiService.getLaboratoriesByDirection(selectedDirection);
    }

    // ИЗМЕНЕНИЕ: Используем наш новый геттер для сортировки
    try {
      laboratories.sort((a, b) {
        final dateA = a.firstDayDate;
        final dateB = b.firstDayDate;

        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1; // Лаборатории без даты в конец
        if (dateB == null) return -1; // Лаборатории без даты в конец

        return dateA.compareTo(dateB);
      });
    } catch (e) {
      print("Ошибка сортировки лабораторий: $e");
    }

    return LaboratoriesState(allLaboratories: laboratories);
  }

  // setSearchQuery остается без изменений
  void setSearchQuery(String query) {
    state = AsyncData(state.value!.copyWith(searchQuery: query));
  }
}

// 3. Провайдер для одной лаборатории
final laboratoryByIdProvider =
FutureProvider.family<Laboratory, String>((ref, id) {
  return ref.read(apiServiceProvider).getLaboratoryById(id);
});