part of 'verify_otp_bloc.dart';


@freezed
class VerifyOtpState with _$VerifyOtpState {
  const factory VerifyOtpState.initial() = _Initial;
  const factory VerifyOtpState.loading() = _Loading;
  const factory VerifyOtpState.verified() = _Verified;
  const factory VerifyOtpState.error(String message) = _Error;
}