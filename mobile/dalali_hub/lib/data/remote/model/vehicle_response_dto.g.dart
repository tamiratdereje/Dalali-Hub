// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleResponseDto _$VehicleResponseDtoFromJson(Map<String, dynamic> json) =>
    VehicleResponseDto(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      color: json['color'] as String,
      vin: json['vin'] as String,
      fuelType: json['fuelType'] as String,
      engineSize: json['engineSize'] as int,
      transmissionType: json['transmissionType'] as String,
      mileage: (json['mileage'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
      condition: json['condition'] as String,
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] as String,
      isApproved: json['isApproved'] as bool,
      owner: UserResponseDto.fromJson(json['owner'] as Map<String, dynamic>),
      numberOfViews: json['numberOfViews'] as int,
    );

Map<String, dynamic> _$VehicleResponseDtoToJson(VehicleResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'color': instance.color,
      'vin': instance.vin,
      'fuelType': instance.fuelType,
      'engineSize': instance.engineSize,
      'transmissionType': instance.transmissionType,
      'mileage': instance.mileage,
      'price': instance.price,
      'location': instance.location.toJson(),
      'condition': instance.condition,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'category': instance.category,
      'isApproved': instance.isApproved,
      'owner': instance.owner.toJson(),
      'numberOfViews': instance.numberOfViews,
    };
