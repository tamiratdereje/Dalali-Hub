// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broker_stat_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrokerStatResponseDto _$BrokerStatResponseDtoFromJson(
        Map<String, dynamic> json) =>
    BrokerStatResponseDto(
      totalListing: json['totalListing'] as int,
      numberOfSuccedListing: json['numberOfSuccedListing'] as int,
      totalNumOfView: json['totalNumOfView'] as int,
      numberOfFavorite: json['numberOfFavorite'] as int,
    );

Map<String, dynamic> _$BrokerStatResponseDtoToJson(
        BrokerStatResponseDto instance) =>
    <String, dynamic>{
      'totalNumOfView': instance.totalNumOfView,
      'totalListing': instance.totalListing,
      'numberOfFavorite': instance.numberOfFavorite,
      'numberOfSuccedListing': instance.numberOfSuccedListing,
    };
