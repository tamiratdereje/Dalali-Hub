// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      sirName: json['sirName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      region: json['region'] as String,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'sirName': instance.sirName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'region': instance.region,
    };
