import 'dart:io';

import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/domain/entity/realstate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'realstate_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RealstateDto {
 final String? id;
  final String title;
  final double price;
  final double? rooms;
  final double? beds;
  final double? baths;
  final double? kitchens;
  final double sizeWidth;
  final double sizeHeight;
  final String sizeUnit;
  final List<String> otherFeatures;
  final String description;
  final bool isApproved;
  final String category;
  final Map location;
  final int? seats;
  final int numberOfViews;
  

  RealstateDto({
    required this.title,
    required this.category,
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
    this.id,
    required this.location,
    this.seats,
    required this.numberOfViews
  });
  Map<String, dynamic> toJson() => _$RealstateDtoToJson(this);

 static RealstateDto toRealstateDto(Realstate realstate) {
    return RealstateDto(
      id: realstate.id,
      title: realstate.title,
      category: realstate.category,
      price: realstate.price,
      rooms: realstate.rooms,
      beds: realstate.beds,
      baths: realstate.baths,
      kitchens: realstate.kitchens,
      sizeWidth: realstate.sizeWidth,
      sizeHeight: realstate.sizeHeight,
      sizeUnit: realstate.sizeUnit,
      otherFeatures: realstate.otherFeatures,
      description: realstate.description,
      isApproved: realstate.isApproved,
      location: {
        "region": realstate.location.region,
        "district": realstate.location.district,
        "ward": realstate.location.ward
      },
      numberOfViews: realstate.numberOfViews,
      
      
    );
  }
}
