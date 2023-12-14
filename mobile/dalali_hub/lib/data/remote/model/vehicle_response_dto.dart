import 'dart:io';

import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/vehicle_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleResponseDto {
  final String id;
  final String make;
  final String model;
  final int year;

  final String color;
  final String vin;
  final String fuelType;
  final int engineSize;
  final String transmissionType;
  final double mileage;
  final double price;
  final LocationDto location;
  final String condition;
  final List<PhotoResponseDto> photos;
  final String category;

  VehicleResponseDto({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.vin,
    required this.fuelType,
    required this.engineSize,
    required this.transmissionType,
    required this.mileage,
    required this.price,
    required this.location,
    required this.condition,
    required this.photos,
    required this.category,
  });

  factory VehicleResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleResponseDtoToJson(this);

  VehicleResponse toVehicleResponse() => VehicleResponse(
        id: id,
        make: make,
        model: model,
        year: year,
        color: color,
        vin: vin,
        fuelType: fuelType,
        engineSize: engineSize,
        transmissionType: transmissionType,
        mileage: mileage,
        price: price,
        location: location.toLocation(),
        condition: condition,
        photos: photos.map((e) => e.toPhotoResponse()).toList(),
        category: category,
      );
}
