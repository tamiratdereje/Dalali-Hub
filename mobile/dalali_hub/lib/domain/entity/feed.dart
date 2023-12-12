import 'dart:io';

import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';

class Feed {
  final String id;
  final String? title;
  final List<PhotoResponse> photos;
  final double? minPrice;
  final double? maxPrice;

  final double? rooms;
  final double? beds;
  final double? baths;
  final double? kitchens;
  final int? seats;

  final double? size;
  final String? sizeUnit;
  final List<String>? otherFeatures;
  final String? description;
  final bool? isApproved;
  final String? category;
  final Location location;

  final String? make;
  final String? model;
  final int? year;

  final String? color;
  final String? vin;
  final String? fuelType;
  final int? engineSize;
  final String? transmissionType;
  final double? mileage;
  final double? price;
  final String? condition;

  Feed({
    required this.id,
    this.title,
    this.category,
    required this.photos,
    this.minPrice,
    this.maxPrice,
    this.rooms,
    this.beds,
    this.baths,
    this.kitchens,
    this.seats,
    this.size,
    this.sizeUnit,
    this.otherFeatures,
    this.description,
    this.isApproved,
    required this.location,
    this.make,
    this.model,
    this.year,
    this.color,
    this.vin,
    this.fuelType,
    this.engineSize,
    this.transmissionType,
    this.mileage,
    this.price,
    this.condition,
  });
}
