import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/laboratory.dart';
import '../data/services/api_service.dart';

final laboratoryByIdProvider = FutureProvider.family<Laboratory, String>((ref, id) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getLaboratoryById(id);
});

final laboratoriesProvider = FutureProvider.family<List<Laboratory>, String?>((ref, direction) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getLaboratories(); //direction: direction
});


// lib/providers/laboratory_provider.dart
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:freezed_annotation/freezed_annotation.dart'; // Нужен пакет freezed
// import 'package:ltfest/data/models/laboratory.dart';
// import 'package:ltfest/data/services/api_service.dart';
//
// part 'laboratory_provider.freezed.dart'; // Сгенерированный файл
//
// // --- 1. Модель состояния для нашего Notifier ---
// @freezed
// abstract class LaboratoryState with _$LaboratoryState {
//   const factory LaboratoryState({
//     @Default([]) List<Laboratory> allLaboratories, // Все загруженные лаборатории
//     @Default([]) List<Laboratory> filteredLaboratories, // Отфильтрованный список для UI
//     @Default(null) String? selectedDirectionId,
//     @Default('') String searchQuery,
//     @Default(true) bool isLoading,
//     @Default(null) String? error,
//   }) = _LaboratoryState;
// }
//
// // --- 2. StateNotifier для управления логикой ---
// class LaboratoryNotifier extends StateNotifier<LaboratoryState> {
//   final ApiService _apiService;
//
//   LaboratoryNotifier(this._apiService) : super(const LaboratoryState()) {
//     // Загружаем данные при первой инициализации
//     fetchLaboratories();
//   }
//
//   // --- МЕТОДЫ ДЛЯ ВЗАИМОДЕЙСТВИЯ С UI ---
//
//   /// Загружает лаборатории из API
//   Future<void> fetchLaboratories({String? directionId}) async {
//     state = state.copyWith(isLoading: true, error: null, selectedDirectionId: directionId);
//     try {
//       final laboratories = await _apiService.getLaboratories(direction: directionId);
//       state = state.copyWith(
//         allLaboratories: laboratories,
//         filteredLaboratories: laboratories, // Изначально списки совпадают
//         isLoading: false,
//       );
//       // После загрузки применяем текущий поисковый фильтр, если он есть
//       _filter();
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }
//
//   /// Обновляет поисковый запрос и запускает фильтрацию
//   void updateSearchQuery(String query) {
//     state = state.copyWith(searchQuery: query);
//     _filter();
//   }
//
//   /// Обновляет выбранное направление и перезагружает данные
//   void updateDirection(String? directionId) {
//     // При смене направления нам нужно заново загрузить данные с сервера
//     fetchLaboratories(directionId: directionId);
//   }
//
//   /// Приватный метод для фильтрации списка
//   void _filter() {
//     final query = state.searchQuery.toLowerCase().trim();
//
//     // Берем исходный (полный) список для фильтрации
//     List<Laboratory> filtered = state.allLaboratories;
//
//     if (query.isNotEmpty) {
//       filtered = filtered.where((lab) {
//         // Ищем совпадения в названии и адресе (можно добавить и другие поля)
//         final titleMatch = lab.title.toLowerCase().contains(query);
//         final addressMatch = lab.address?.toLowerCase().contains(query) ?? false;
//         return titleMatch || addressMatch;
//       }).toList();
//     }
//
//     // Обновляем состояние отфильтрованным списком
//     state = state.copyWith(filteredLaboratories: filtered, error: null);
//   }
// }
//
// // --- 3. Провайдер для доступа к нашему Notifier ---
// final laboratoryNotifierProvider = StateNotifierProvider<LaboratoryNotifier, LaboratoryState>((ref) {
//   final apiService = ref.read(apiServiceProvider);
//   return LaboratoryNotifier(apiService);
// });
//
//
// final laboratoryByIdProvider = Provider.family<Laboratory?, String>((ref, id) {
//   final state = ref.watch(laboratoryNotifierProvider);
//   return state.allLaboratories.firstWhere((lab) => lab.id.toString() == id);
// });

// ПРОВАЙДЕРЫ НИЖЕ БОЛЬШЕ НЕ НУЖНЫ, их можно удалить или закомментировать
/*
final laboratoryByIdProvider = ...
final laboratoriesProvider = ...
final searchQueryProvider = ...
final selectedDirectionIdProvider = ...
*/