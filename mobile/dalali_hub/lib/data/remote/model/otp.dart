import 'package:dalali_hub/domain/entity/verify_otp.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp.g.dart';

@JsonSerializable(explicitToJson: true)
class Otp {
  String? otp;
  String? phoneNumber;
  String? email;
  String otpPurpose;
  String otpType;

  Otp(
      {required this.otp,
      this.phoneNumber,
      this.email,
      required this.otpPurpose,
      required this.otpType});

  Map<String, dynamic> toJson() => _$OtpToJson(this);

  factory Otp.fromEntity(VerifyOtp otp) {
    return Otp(
      otp: otp.otp,
      phoneNumber: otp.phoneNumber,
      email: otp.email,
      otpPurpose: otp.purpose.name,
      otpType: otp.otpType.name,
    );
  }
}
