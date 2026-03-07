import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/data/models/laboratory_learning_type.dart';
import 'package:ltfest/data/repositories/laboratory_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'laboratory_provider.g.dart';

class LaboratoriesState {
  final List<Laboratory> allLaboratories;
  final String searchQuery;
  final List<String> selectedCities;
  final List<String> selectedLearningTypes;

  const LaboratoriesState({
    this.allLaboratories = const [],
    this.searchQuery = '',
    this.selectedCities = const [],
    this.selectedLearningTypes = const [],
  });

  Set<String> get uniqueCities {
    return allLaboratories
        .map((l) => (l.city ?? '').trim())
        .where((c) => c.isNotEmpty)
        .toSet();
  }

  List<dynamic> get uniqueLearningTypes {
    return allLaboratories
        .expand((l) => l.learningTypes ?? [])
        .map((lt) => lt.type)
        .toSet()
        .toList();
  }

  List<String> getUniqueCitiesForDirection(String? direction) {
    final labs = direction == null || direction.isEmpty
        ? allLaboratories
        : allLaboratories
            .where((l) => l.direction.title == direction)
            .toList();
    return labs
        .map((l) => (l.city ?? '').trim())
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList();
  }

  List<String> getUniqueLearningTypesForDirection(String? direction) {
    final labs = direction == null || direction.isEmpty
        ? allLaboratories
        : allLaboratories
            .where((l) => l.direction.title == direction)
            .toList();
    return labs
        .expand<LearningType>((l) => l.learningTypes ?? <LearningType>[])
        .map<String>((lt) => lt.type)
        .toSet()
        .toList();
  }

  List<Laboratory> getFilteredLaboratories(String? direction) {
    var labs = direction == null || direction.isEmpty
        ? allLaboratories
        : allLaboratories
            .where((l) => l.direction.title == direction)
            .toList();
    return labs.where((lab) {
      final titleMatch = searchQuery.isEmpty ||
          lab.title.toLowerCase().contains(searchQuery.toLowerCase());
      final cityMatch = selectedCities.isEmpty ||
          selectedCities.any(
              (city) => (lab.city ?? '').toLowerCase().contains(city.toLowerCase()));
      final typeMatch = selectedLearningTypes.isEmpty ||
          (lab.learningTypes ?? []).any(
              (lt) => selectedLearningTypes.contains(lt.type));
      return titleMatch && cityMatch && typeMatch;
    }).toList();
  }

  List<Laboratory> get filteredLaboratories {
    return getFilteredLaboratories(null);
  }

  LaboratoriesState copyWith({
    List<Laboratory>? allLaboratories,
    String? searchQuery,
    List<String>? selectedCities,
    List<String>? selectedLearningTypes,
  }) {
    return LaboratoriesState(
      allLaboratories: allLaboratories ?? this.allLaboratories,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCities: selectedCities ?? this.selectedCities,
      selectedLearningTypes: selectedLearningTypes ?? this.selectedLearningTypes,
    );
  }
}

@Riverpod(keepAlive: true)
class LaboratoriesNotifier extends _$LaboratoriesNotifier {
  LaboratoryRepository get _repo => ref.read(laboratoryRepositoryProvider);

  @override
  Future<LaboratoriesState> build() async {
    final laboratories = await _repo.getLaboratories();

    try {
      laboratories.sort((a, b) {
        final dateA = a.firstDayDate;
        final dateB = b.firstDayDate;
        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateA.compareTo(dateB);
      });
    } catch (e) {
      debugPrint("Ошибка сортировки лабораторий: $e");
    }

    return LaboratoriesState(allLaboratories: laboratories);
  }

  void setSearchQuery(String query) {
    final prev = state.value!;
    state = AsyncData(prev.copyWith(searchQuery: query));
  }

  void setSelectedCities(List<String> cities) {
    final prev = state.value!;
    state = AsyncData(prev.copyWith(selectedCities: cities));
  }

  void setSelectedLearningTypes(List<String> types) {
    final prev = state.value!;
    state = AsyncData(prev.copyWith(selectedLearningTypes: types));
  }
}

final laboratoryByIdProvider =
    FutureProvider.family<Laboratory, String>((ref, id) async {
  final repo = ref.read(laboratoryRepositoryProvider);
  try {
    return await repo.getLaboratoryById(id);
  } catch (e, st) {
    Error.throwWithStackTrace(e, st);
  }
});
