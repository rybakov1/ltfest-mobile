import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  /// Пользователь не аутентифицирован (гость).
  const factory AuthState.unauthenticated() = Unauthenticated;
  /// Пользователь аутентифицирован и его профиль заполнен.
  const factory AuthState.authenticated({required User user}) = Authenticated;
  /// Пользователь вошел в систему (например, через OTP), но должен завершить регистрацию (заполнить профиль).
  const factory AuthState.needsRegistration({required User user}) = NeedsRegistration;
}