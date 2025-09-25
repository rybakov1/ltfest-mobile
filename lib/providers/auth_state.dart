import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated({required User user}) = Authenticated;
  const factory AuthState.needsRegistration({required User user}) = NeedsRegistration;
}
