import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/domain/entity/login_response.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  final String token;
  final String userId;

  LoginResponseDto(this.userId, {
    required this.token,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);

  LoginResponse toLoginResponse() => LoginResponse(token: token);
}
