import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

class TokenStorage {
  final _storage = const FlutterSecureStorage();
  // Переименовали ключ для ясности и чтобы избежать конфликтов со старым кэшем
  static const _jwtKey = 'jwt';

  // Упрощенный метод сохранения. Принимает только один токен.
  Future<void> saveToken({required String jwt}) async {
    await _storage.write(key: _jwtKey, value: jwt);
  }

  // Переименован для ясности. Проверяет срок годности.
  Future<String?> getJwt() async {
    final token = await _storage.read(key: _jwtKey);
    if (token == null) {
      return null;
    }
    // Проверка на срок годности токена
    if (JwtDecoder.isExpired(token)) {
      await clearToken(); // Если токен истек, удаляем его
      return null;
    }
    return token;
  }

  // Метод getRefreshToken() больше не нужен.

  // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Strapi помещает ID пользователя в поле 'id'
  Future<int?> getUserId() async {
    final token = await getJwt();
    if (token == null) return null;
    try {
      final decoded = JwtDecoder.decode(token);
      // Ищем поле 'id'
      return decoded['id'] as int?;
    } catch (e) {
      return null; // Если токен невалидный
    }
  }

  // Упрощенный метод очистки
  Future<void> clearToken() async {
    await _storage.delete(key: _jwtKey);
  }
}