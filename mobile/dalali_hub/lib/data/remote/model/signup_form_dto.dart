import 'package:dalali_hub/domain/entity/signup.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_form_dto.g.dart';

@JsonSerializable()
class SignupFormDto {
  final String firstName;
  final String middleName;
  final String sirName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String region;
  final String password;

  SignupFormDto(
      {required this.firstName,
      required this.middleName,
      required this.sirName,
      required this.email,
      required this.phoneNumber,
      required this.gender,
      required this.region,
      required this.password});

  factory SignupFormDto.fromJson(Map<String, dynamic> json) =>
      _$SignupFormDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SignupFormDtoToJson(this);

  // from domain
  factory SignupFormDto.fromEntity(SignupForm form) => SignupFormDto(
      firstName: form.firstName,
      middleName: form.middleName,
      sirName: form.sirName,
      email: form.email,
      phoneNumber: '+251${form.phoneNumber}',
      gender: form.gender.toUpperCase(),
      region: form.region.toUpperCase(),
      password: form.password);
}
