import 'package:ltfest/data/repositories/misc_repository.dart';
import '../../domain/repository/support_repository.dart';

class SupportRepositoryImpl implements SupportRepository {
  final MiscRepository _miscRepo;

  SupportRepositoryImpl(this._miscRepo);

  @override
  Future<void> sendSupportRequest({
    required String name,
    required String email,
    required String phone,
    required String reason,
    required String message,
    required String device,
    required String appVersion,
    required List<String> filePaths,
  }) async {
    final List<int> attachmentIds = [];

    for (final path in filePaths) {
      final id = await _miscRepo.uploadFile(path);
      attachmentIds.add(id);
    }

    await _miscRepo.sendSupportMessage(
      name: name,
      email: email,
      phone: phone,
      reason: reason,
      message: message,
      device: device,
      appVersion: appVersion,
      attachmentIds: attachmentIds,
    );
  }
}
