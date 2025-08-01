import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/direction.dart';
import 'package:ltfest/data/services/api_service.dart';

// Этот провайдер загружает список всех доступных направлений с API
final directionsProvider = FutureProvider<List<Direction>>((ref) {
  return ref.watch(apiServiceProvider).getDirections();
});

// ИЗМЕНЕНИЕ: Тип теперь String?, начальное состояние - null ("Все")
final selectedDirectionProvider = StateProvider<String?>((ref) => null);