// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoResponseDto _$PhotoResponseDtoFromJson(Map<String, dynamic> json) =>
    PhotoResponseDto(
      id: json['id'] as String,
      publicUrl: json['publicUrl'] as String,
      secoureUrl: json['secoureUrl'] as String,
    );

Map<String, dynamic> _$PhotoResponseDtoToJson(PhotoResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'publicUrl': instance.publicUrl,
      'secoureUrl': instance.secoureUrl,
    };
