
import 'package:json_annotation/json_annotation.dart';

part 'otp_verification_response_dto.g.dart';
@JsonSerializable()
class OtpVerificationResponseDto {
  final String? token;


  OtpVerificationResponseDto({this.token});

  factory OtpVerificationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerificationResponseDtoToJson(this);
}