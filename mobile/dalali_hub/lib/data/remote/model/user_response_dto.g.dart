// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) =>
    UserResponseDto(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      sirName: json['sirName'] as String,
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$UserResponseDtoToJson(UserResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'sirName': instance.sirName,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
    };
