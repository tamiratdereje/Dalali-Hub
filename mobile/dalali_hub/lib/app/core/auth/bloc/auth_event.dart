part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.updateAuthStatus() = _UpdateAuthStatus;
  const factory AuthEvent.authenticate() = _Authenticate;
  const factory AuthEvent.unauthenticate() = _Unauthenticate;

}