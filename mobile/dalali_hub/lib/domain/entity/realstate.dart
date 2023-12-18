import 'dart:io';

import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/entity/user_response.dart';

class Realstate {
  final String? id;
  final String title;
  final List<String> photos;
  final double price;

  final double? rooms;
  final double? beds;
  final double? baths;
  final double? kitchens;
  final int? seats;
  
  final double sizeWidth;
  final double sizeHeight;
  final String sizeUnit;
  final List<String> otherFeatures;
  final String description;
  final bool isApproved;
  final String category;
  final Location location;
  final int numberOfViews;
  

  Realstate({
    this.id,
    required this.title,
    required this.category,
    required this.photos,
    required this.price,
    this.rooms,
    this.beds,
    this.baths,
    this.kitchens,
    required this.sizeWidth,
    required this.sizeHeight,
    required this.sizeUnit,
    required this.otherFeatures,
    required this.description,
    required this.isApproved,
    required this.location,
    this.seats,
    required this.numberOfViews,
  });
}
