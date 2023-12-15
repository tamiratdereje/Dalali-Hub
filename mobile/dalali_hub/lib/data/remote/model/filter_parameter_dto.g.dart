// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_parameter_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterParameterDto _$FilterParameterDtoFromJson(Map<String, dynamic> json) =>
    FilterParameterDto(
      region: json['region'] as String?,
      district: json['district'] as String?,
      ward: json['ward'] as String?,
      lowerRooms: json['lowerRooms'] as int?,
      upperRooms: json['upperRooms'] as int?,
      lowerSeats: json['lowerSeats'] as int?,
      upperSeats: json['upperSeats'] as int?,
      widthSize: (json['widthSize'] as num?)?.toDouble(),
      heightSize: (json['heightSize'] as num?)?.toDouble(),
      lowerPrice: (json['lowerPrice'] as num?)?.toDouble(),
      upperPrice: (json['upperPrice'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      make: json['make'] as String?,
      minYears: json['minYears'] as int?,
      maxYears: json['maxYears'] as int?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$FilterParameterDtoToJson(FilterParameterDto instance) =>
    <String, dynamic>{
      'region': instance.region,
      'district': instance.district,
      'ward': instance.ward,
      'lowerRooms': instance.lowerRooms,
      'upperRooms': instance.upperRooms,
      'lowerSeats': instance.lowerSeats,
      'upperSeats': instance.upperSeats,
      'widthSize': instance.widthSize,
      'heightSize': instance.heightSize,
      'lowerPrice': instance.lowerPrice,
      'upperPrice': instance.upperPrice,
      'currency': instance.currency,
      'make': instance.make,
      'minYears': instance.minYears,
      'maxYears': instance.maxYears,
      'category': instance.category,
    };
