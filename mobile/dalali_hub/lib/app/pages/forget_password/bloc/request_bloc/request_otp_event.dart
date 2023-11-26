part of 'request_otp_bloc.dart';

@freezed
class RequestOtpEvent with _$RequestOtpEvent {
  const factory RequestOtpEvent.requestOtp(VerifyOtp verifyOtp) =
      _RequestOtp;
}
