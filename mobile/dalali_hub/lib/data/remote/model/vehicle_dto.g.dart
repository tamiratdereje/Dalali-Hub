// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDto _$VehicleDtoFromJson(Map<String, dynamic> json) => VehicleDto(
      id: json['id'] as String?,
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
      location: json['location'] as Map<String, dynamic>,
      condition: json['condition'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$VehicleDtoToJson(VehicleDto instance) =>
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
      'location': instance.location,
      'condition': instance.condition,
      'category': instance.category,
    };
