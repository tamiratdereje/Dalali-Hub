import 'dart:io';

import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/domain/entity/house.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'house_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class HouseDto {
  final String? id;
  final String title;
  final double minPrice;
  final double maxPrice;
  final double rooms;
  final double beds;
  final double baths;
  final double kitchens;
  final double size;
  final String sizeUnit;
  final List<String> otherFeatures;
  final String description;
  final bool isApproved;
  final String category;
  final Map location;

  HouseDto({
    required this.title,
    required this.category,
    required this.minPrice,
    required this.maxPrice,
    required this.rooms,
    required this.beds,
    required this.baths,
    required this.kitchens,
    required this.size,
    required this.sizeUnit,
    required this.otherFeatures,
    required this.description,
    required this.isApproved,
    this.id,
    required this.location,
  });
  Map<String, dynamic> toJson() => _$HouseDtoToJson(this);

 static HouseDto toHouseDto(House house) {
    return HouseDto(
      id: house.id,
      title: house.title,
      category: house.category,
      minPrice: house.minPrice,
      maxPrice: house.maxPrice,
      rooms: house.rooms,
      beds: house.beds,
      baths: house.baths,
      kitchens: house.kitchens,
      size: house.size,
      sizeUnit: house.sizeUnit,
      otherFeatures: house.otherFeatures,
      description: house.description,
      isApproved: house.isApproved,
      location: {
        "region": house.location.region,
        "district": house.location.district,
        "ward": house.location.ward
      },
    );
  }
}
