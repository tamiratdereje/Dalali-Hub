import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/user_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class UserResponseDto {
  final String id;
  final String firstName;
  final String middleName;
  final String sirName;
  final List<PhotoResponseDto> photos;
  final String email;
  final String phoneNumber;
  final String gender;

  UserResponseDto(
      {required this.id,
      required this.firstName,
      required this.middleName,
      required this.sirName,
      required this.photos,
      required this.email,
      required this.phoneNumber,
      required this.gender});

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  UserResponse toUserResponse() => UserResponse(
      id: id,
      firstName: firstName,
      middleName: middleName,
      sirName: sirName,
      phoneNumber: phoneNumber,
      photos: photos,
      email: email,
      gender: gender);

      toJson() {}

}
