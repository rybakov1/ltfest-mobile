import 'package:ltfest/data/services/api_service.dart';
import '../../domain/repository/support_repository.dart';

class SupportRepositoryImpl implements SupportRepository {
  final ApiService _apiService;

  SupportRepositoryImpl(this._apiService);

  @override
  Future<void> sendSupportRequest({
    required String email,
    required String phone,
    required String reason,
    required String message,
    required List<String> filePaths,
  }) async {
    final List<int> attachmentIds = [];
    
    for (final path in filePaths) {
      final id = await _apiService.uploadFile(path);
      attachmentIds.add(id);
    }

    await _apiService.sendSupportMessage(
      email: email,
      phone: phone,
      reason: reason,
      message: message,
      attachmentIds: attachmentIds,
    );
  }
}
