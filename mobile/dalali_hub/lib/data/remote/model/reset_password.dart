import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:dalali_hub/domain/entity/reset_password.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password.g.dart';

@JsonSerializable(explicitToJson: true)
class ResetPasswordDto {
  final String newPassword;
  final String resetToken;

  ResetPasswordDto({required this.newPassword, required this.resetToken});

  Map<String, dynamic> toJson() => _$ResetPasswordDtoToJson(this);

  factory ResetPasswordDto.fromEntity(
      ResetPassword resetPassword, SharedPreference pref) {
    return ResetPasswordDto(
      newPassword: resetPassword.newPassword,
      resetToken: pref.getString(resetPasswordKey) ?? '',
    );
  }
}
