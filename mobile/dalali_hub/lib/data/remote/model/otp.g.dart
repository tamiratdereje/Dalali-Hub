// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Otp _$OtpFromJson(Map<String, dynamic> json) => Otp(
      otp: json['otp'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      otpPurpose: json['otpPurpose'] as String,
      otpType: json['otpType'] as String,
    );

Map<String, dynamic> _$OtpToJson(Otp instance) => <String, dynamic>{
      'otp': instance.otp,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'otpPurpose': instance.otpPurpose,
      'otpType': instance.otpType,
    };
