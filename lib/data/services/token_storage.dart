import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_endpoints.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final authInvalidationProvider = StateProvider<int>((ref) => 0);

class TokenStorage {
  final _storage = const FlutterSecureStorage();
  static const _jwtKey = 'jwt';
  static const _serverBaseUrlKey = 'server_base_url';

  Future<void> saveToken({
    required String jwt,
    required String serverBaseUrl,
  }) async {
    await _storage.write(key: _jwtKey, value: jwt);
    await _storage.write(key: _serverBaseUrlKey, value: serverBaseUrl);
  }

  Future<String?> getJwt() async {
    final token = await _storage.read(key: _jwtKey);
    if (token == null) {
      return null;
    }
    final storedServerBaseUrl = await _storage.read(key: _serverBaseUrlKey);
    if (storedServerBaseUrl != ApiEndpoints.baseStrapiUrl) {
      await clearToken();
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
    await _storage.delete(key: _serverBaseUrlKey);
  }
}
