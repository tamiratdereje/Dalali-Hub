import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:dalali_hub/domain/entity/reset_password.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password.g.dart';

@JsonSerializable(explicitToJson: true)
class ResetPasswordDto {
  final String newPassword;
  final String token;

  ResetPasswordDto({required this.newPassword, required this.token});

  Map<String, dynamic> toJson() => _$ResetPasswordDtoToJson(this);

  factory ResetPasswordDto.fromEntity(
      ResetPassword resetPassword, SharedPreference pref) {
    return ResetPasswordDto(
      newPassword: resetPassword.newPassword,
      token: pref.getString(resetPasswordKey) ?? '',
    );
  }
}
