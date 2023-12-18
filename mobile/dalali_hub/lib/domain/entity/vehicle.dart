import 'dart:io';

import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';

class Vehicle {
  final String? id;
  final String make;
  final double price;

  final String model;
  final int year;
  final String color;
  final String fuelType;
  final int engineSize;
  final String vin;
  final String transmissionType;
  final double mileage;

  final Location location;

  final String condition;

  final List<String> photos;
  final String category;
  final bool isApproved;
  final int numberOfViews;

  Vehicle(
      {this.id,
      required this.make,
      required this.model,
      required this.photos,
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
      required this.numberOfViews});
}
