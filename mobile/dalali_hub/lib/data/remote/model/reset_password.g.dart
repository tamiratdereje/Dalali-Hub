// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordDto _$ResetPasswordDtoFromJson(Map<String, dynamic> json) =>
    ResetPasswordDto(
      newPassword: json['newPassword'] as String,
      resetToken: json['resetToken'] as String,
    );

Map<String, dynamic> _$ResetPasswordDtoToJson(ResetPasswordDto instance) =>
    <String, dynamic>{
      'newPassword': instance.newPassword,
      'resetToken': instance.resetToken,
    };
