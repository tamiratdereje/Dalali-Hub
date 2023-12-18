import 'dart:io';

import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/data/remote/model/user_response_dto.dart';
import 'package:dalali_hub/domain/entity/vehicle.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleDto {
  final String? id;
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
  final Map location;
  final String condition;
  final String category;
  final bool isApproved;
      final int numberOfViews;



  VehicleDto({
    this.id,
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
    required this.category,
    required this.isApproved,
        required this.numberOfViews,

  });

  factory VehicleDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDtoToJson(this);

  static VehicleDto toVehicleDto(Vehicle vehicle) {
    return VehicleDto(
      id: vehicle.id,
      make: vehicle.make,
      model: vehicle.model,
      year: vehicle.year,
      color: vehicle.color,
      vin: vehicle.vin,
      fuelType: vehicle.fuelType,
      engineSize: vehicle.engineSize,
      transmissionType: vehicle.transmissionType,
      mileage: vehicle.mileage,
      price: vehicle.price,
      location: {
        "region": vehicle.location.region,
        "district": vehicle.location.district,
        "ward": vehicle.location.ward
      },
      condition: vehicle.condition,
      category: vehicle.category,
      isApproved: vehicle.isApproved,
      numberOfViews: vehicle.numberOfViews

    );
  }
}
