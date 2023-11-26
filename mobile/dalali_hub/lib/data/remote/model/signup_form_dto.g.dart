// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_form_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupFormDto _$SignupFormDtoFromJson(Map<String, dynamic> json) =>
    SignupFormDto(
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      sirName: json['sirName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      region: json['region'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignupFormDtoToJson(SignupFormDto instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'sirName': instance.sirName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'region': instance.region,
      'password': instance.password,
    };
