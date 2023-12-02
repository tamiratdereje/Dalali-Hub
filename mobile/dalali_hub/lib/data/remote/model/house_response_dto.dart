import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'house_response_dto.g.dart';

@JsonSerializable()
class HouseResponseDto {
  final String id;
  final String title;
  final List<PhotoResponseDto> photos;
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
  final LocationDto location;

  HouseResponseDto({
    required this.title,
    required this.category,
    required this.id,
    required this.photos,
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
    required this.location,
  });

  factory HouseResponseDto.fromJson(Map<String, dynamic> json) =>
      _$HouseResponseDtoFromJson(json);

  HouseResponse toHouseResponse() => HouseResponse(
        title: title,
        category: category,
        id: id,
        photos: photos.map((e) => e.toPhotoResponse()).toList(),
        minPrice: minPrice,
        maxPrice: maxPrice,
        rooms: rooms,
        beds: beds,
        baths: baths,
        kitchens: kitchens,
        size: size,
        sizeUnit: sizeUnit,
        otherFeatures: otherFeatures,
        description: description,
        isApproved: isApproved,
        location: location.toLocation(),
      );
}
