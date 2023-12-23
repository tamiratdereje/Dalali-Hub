import 'package:dalali_hub/domain/entity/signup.dart';
import 'package:dalali_hub/domain/entity/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String firstName;
  final String middleName;
  final String sirName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String region;

  UserDto(
      {required this.firstName,
      required this.middleName,
      required this.sirName,
      required this.email,
      required this.phoneNumber,
      required this.gender,
      required this.region,
     });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  // from domain
  factory UserDto.fromEntity(User user) => UserDto(
      firstName: user.firstName,
      middleName: user.middleName,
      sirName: user.sirName,
      email: user.email,
      phoneNumber: '+251${user.phoneNumber}',
      gender: user.gender.toUpperCase(),
      region: user.region.toUpperCase(),
  );
}
