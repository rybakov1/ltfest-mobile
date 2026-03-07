import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/repositories/misc_repository.dart';
import '../../data/repository/support_repository_impl.dart';
import '../../domain/repository/support_repository.dart';

final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  return SupportRepositoryImpl(ref.watch(miscRepositoryProvider));
});

final supportProvider =
    StateNotifierProvider<SupportNotifier, AsyncValue<void>>((ref) {
  return SupportNotifier(ref.watch(supportRepositoryProvider));
});

class SupportNotifier extends StateNotifier<AsyncValue<void>> {
  final SupportRepository _repository;

  SupportNotifier(this._repository) : super(const AsyncData(null));

  Future<void> submit({
    required String name,
    required String email,
    required String phone,
    required String reason,
    required String message,
    required String device,
    required String appVersion,
    required List<String> filePaths,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.sendSupportRequest(
          name: name,
          email: email,
          phone: phone,
          reason: reason,
          message: message,
          device: device,
          appVersion: appVersion,
          filePaths: filePaths,
        ));
  }
}
