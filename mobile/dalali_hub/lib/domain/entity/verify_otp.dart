import 'package:dalali_hub/domain/type/types.dart';

class VerifyOtp {
  String? otp;
  String? phoneNumber;
  String? email;
  OtpPurpose purpose;
  OtpType otpType;

  VerifyOtp(
      {this.otp,
      this.phoneNumber,
      this.email,
      required this.purpose,
      required this.otpType});
}
