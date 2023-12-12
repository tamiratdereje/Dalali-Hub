import 'dart:io';

import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';

class RealstateResponse {
  final String id;
  final String title;
  final List<PhotoResponse> photos;
  final double minPrice;
  final double maxPrice;

  final double? rooms;
  final double? beds;
  final double? baths;
  final double? kitchens;
  final int? seats;
  
  final double size;
  final String sizeUnit;
  final List<String> otherFeatures;
  final String description;
  final bool isApproved;
  final String category;
  final Location location;
  
  

  RealstateResponse({
    required this.id,
    required this.title,
    required this.category,
    required this.photos,
    required this.minPrice,
    required this.maxPrice,
    this.rooms,
    this.beds,
    this.baths,
    this.kitchens,
    required this.size,
    required this.sizeUnit,
    required this.otherFeatures,
    required this.description,
    required this.isApproved,
    required this.location,
    this.seats,
  });
}
