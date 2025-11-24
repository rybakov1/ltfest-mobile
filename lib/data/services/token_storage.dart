import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

class TokenStorage {
  final _storage = const FlutterSecureStorage();
  static const _jwtKey = 'jwt';

  Future<void> saveToken({required String jwt}) async {
    await _storage.write(key: _jwtKey, value: jwt);
  }

  Future<String?> getJwt() async {
    final token = await _storage.read(key: _jwtKey);
    if (token == null) {
      return null;
    }
    if (JwtDecoder.isExpired(token)) {
      await clearToken();
      return null;
    }
    return token;
  }

  Future<int?> getUserId() async {
    final token = await getJwt();
    if (token == null) return null;
    try {
      final decoded = JwtDecoder.decode(token);
      return decoded['id'] as int?;
    } catch (e) {
      return null;
    }
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _jwtKey);
  }
}
