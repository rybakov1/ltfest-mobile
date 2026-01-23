abstract class SupportRepository {
  Future<void> sendSupportRequest({
    required String email,
    required String phone,
    required String reason,
    required String message,
    required List<String> filePaths,
  });
}
