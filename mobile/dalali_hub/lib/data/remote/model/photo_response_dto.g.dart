// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoResponseDto _$PhotoResponseDtoFromJson(Map<String, dynamic> json) =>
    PhotoResponseDto(
      id: json['id'] as String,
      publicId: json['publicId'] as String,
      secureUrl: json['secureUrl'] as String,
    );

Map<String, dynamic> _$PhotoResponseDtoToJson(PhotoResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'publicId': instance.publicId,
      'secureUrl': instance.secureUrl,
    };
