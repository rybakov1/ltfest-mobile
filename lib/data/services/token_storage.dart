import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synchronized/synchronized.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

class TokenStorage {
  final _storage = const FlutterSecureStorage();
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  final _lock = Lock();

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  Future<String?> getAccessToken() async {
    return await _lock.synchronized(() async {
      final token = await _storage.read(key: _accessTokenKey);
      if (token == null || JwtDecoder.isExpired(token)) {
        await _storage.delete(key: _accessTokenKey);
        return null;
      }
      return token;
    });
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<int?> getUserId() async {
    final token = await getAccessToken();
    if (token == null) return null;
    final decoded = JwtDecoder.decode(token);
    return int.tryParse(decoded['user_id']?.toString() ?? '');
  }

  Future<void> clearTokens() async {
    await _lock.synchronized(() async {
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
    });
  }
}
