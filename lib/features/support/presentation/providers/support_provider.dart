import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/services/api_service.dart';
import '../../data/repository/support_repository_impl.dart';
import '../../domain/repository/support_repository.dart';

final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  return SupportRepositoryImpl(ref.watch(apiServiceProvider));
});

final supportProvider = StateNotifierProvider<SupportNotifier, AsyncValue<void>>((ref) {
  return SupportNotifier(ref.watch(supportRepositoryProvider));
});

class SupportNotifier extends StateNotifier<AsyncValue<void>> {
  final SupportRepository _repository;

  SupportNotifier(this._repository) : super(const AsyncData(null));

  Future<void> submit({
    required String email,
    required String phone,
    required String reason,
    required String message,
    required List<String> filePaths,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.sendSupportRequest(
          email: email,
          phone: phone,
          reason: reason,
          message: message,
          filePaths: filePaths,
        ));
  }
}
