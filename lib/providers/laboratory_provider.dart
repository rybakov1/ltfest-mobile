import 'dart:async';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'laboratory_provider.g.dart';

class LaboratoriesState {
  final List<Laboratory> allLaboratories;
  final List<String> selectedCities;
  final List<String> selectedLearningTypes;
  final String searchQuery;

  LaboratoriesState({
    this.allLaboratories = const [],
    this.selectedCities = const [],
    this.selectedLearningTypes = const [],
    this.searchQuery = '',
  });

  List<String> get uniqueCities {
    return allLaboratories
        .map((f) => f.address?.split(',').first.trim() ?? '')
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }

  List<dynamic> get uniqueLearningTypes {
    return allLaboratories
        .expand((l) => l.learningTypes!.map((lt) => lt.type))
        .where((t) => t.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }

  List<Laboratory> getFilteredLaboratories(String? direction) {
    return allLaboratories.where((laboratory) {
      final dirMatch = direction == null || laboratory.direction.title == direction;
      final titleMatch = searchQuery.isEmpty ||
          laboratory.title.toLowerCase().contains(searchQuery.toLowerCase());
      final addressMatch = selectedCities.isEmpty ||
          selectedCities.any((city) =>
          laboratory.address?.toLowerCase().contains(city.toLowerCase()) ??
              false);
      final learningTypeMatch = selectedLearningTypes.isEmpty ||
          (laboratory.learningTypes?.any((lt) =>
              selectedLearningTypes.contains(lt.type)) ??
              false);
      return dirMatch && titleMatch && addressMatch && learningTypeMatch;
    }).toList();
  }

  List<String> getUniqueCitiesForDirection(String? direction) {
    final labs = direction == null
        ? allLaboratories
        : allLaboratories.where((l) => l.direction.title == direction).toList();
    return labs
        .map((f) => f.address?.split(',').first.trim() ?? '')
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }

  List<String> getUniqueLearningTypesForDirection(String? direction) {
    final labs = direction == null
        ? allLaboratories
        : allLaboratories.where((l) => l.direction.title == direction).toList();
    return labs
        .expand((l) => l.learningTypes!.map((lt) => lt.type))
        .where((t) => t.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }

  LaboratoriesState copyWith({
    List<Laboratory>? allLaboratories,
    List<String>? selectedCities,
    List<String>? selectedLearningTypes,
    String? searchQuery,
  }) {
    return LaboratoriesState(
      allLaboratories: allLaboratories ?? this.allLaboratories,
      selectedCities: selectedCities ?? this.selectedCities,
      selectedLearningTypes: selectedLearningTypes ?? this.selectedLearningTypes,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

@Riverpod(keepAlive: true)
class LaboratoriesNotifier extends _$LaboratoriesNotifier {
  @override
  Future<LaboratoriesState> build() async {
    final apiService = ref.read(apiServiceProvider);

    final laboratories = await apiService.getLaboratories();

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
      print("Ошибка сортировки лабораторий: $e");
    }

    return LaboratoriesState(allLaboratories: laboratories);
  }

  void setSearchQuery(String query) {
    state = AsyncData(state.value!.copyWith(searchQuery: query));
  }

  void setSelectedCities(List<String> cities) {
    state = AsyncData(state.value!.copyWith(selectedCities: cities));
  }

  void setSelectedLearningTypes(List<String> types) {
    state = AsyncData(state.value!.copyWith(selectedLearningTypes: types));
  }
}

final laboratoryByIdProvider =
FutureProvider.family<Laboratory, String>((ref, id) {
  return ref.read(apiServiceProvider).getLaboratoryById(id);
});