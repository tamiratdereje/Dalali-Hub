// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
      region: json['region'] as String,
      district: json['district'] as String,
      ward: json['ward'] as String,
    );

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'region': instance.region,
      'district': instance.district,
      'ward': instance.ward,
    };
