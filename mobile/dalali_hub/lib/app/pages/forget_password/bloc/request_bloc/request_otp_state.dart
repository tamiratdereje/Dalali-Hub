part of 'request_otp_bloc.dart';

@freezed
class RequestOtpState with _$RequestOtpState {
  const factory RequestOtpState.initial() = _Initial;
  const factory RequestOtpState.loading() = _Loading;
  const factory RequestOtpState.sent() = _Sent;
  const factory RequestOtpState.error(String message) = _Error;
}
