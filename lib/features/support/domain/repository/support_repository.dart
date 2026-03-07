abstract class SupportRepository {
  Future<void> sendSupportRequest({
    required String name,
    required String email,
    required String phone,
    required String reason,
    required String message,
    required String device,
    required String appVersion,
    required List<String> filePaths,
  });
}
