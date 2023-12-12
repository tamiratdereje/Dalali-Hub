import 'dart:io';

import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/domain/entity/realstate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'realstate_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RealstateDto {
 final String? id;
  final String title;
  final double minPrice;
  final double maxPrice;
  final double? rooms;
  final double? beds;
  final double? baths;
  final double? kitchens;
  final double size;
  final String sizeUnit;
  final List<String> otherFeatures;
  final String description;
  final bool isApproved;
  final String category;
  final Map location;
  final int? seats;

  RealstateDto({
    required this.title,
    required this.category,
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
    this.id,
    required this.location,
    this.seats,
  });
  Map<String, dynamic> toJson() => _$RealstateDtoToJson(this);

 static RealstateDto toRealstateDto(Realstate realstate) {
    return RealstateDto(
      id: realstate.id,
      title: realstate.title,
      category: realstate.category,
      minPrice: realstate.minPrice,
      maxPrice: realstate.maxPrice,
      rooms: realstate.rooms,
      beds: realstate.beds,
      baths: realstate.baths,
      kitchens: realstate.kitchens,
      size: realstate.size,
      sizeUnit: realstate.sizeUnit,
      otherFeatures: realstate.otherFeatures,
      description: realstate.description,
      isApproved: realstate.isApproved,
      location: {
        "region": realstate.location.region,
        "district": realstate.location.district,
        "ward": realstate.location.ward
      },
    );
  }
}
