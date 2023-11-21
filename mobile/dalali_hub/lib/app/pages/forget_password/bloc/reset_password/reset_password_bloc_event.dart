part of 'reset_password_bloc_bloc.dart';

@freezed
class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.resetPassword(ResetPassword resetPassword) =
      _ResetPassword;
}
