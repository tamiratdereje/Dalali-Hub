import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_response_dto.g.dart';

@JsonSerializable()
class FeedResponseDto {
  final String id;
  final String? title;
  final List<PhotoResponseDto> photos;
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
  final LocationDto location;
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

  FeedResponseDto({
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

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseDtoFromJson(json);

  Feed toFeed() => Feed(
        id: id,
        title: title,
        category: category,
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
        condition: condition,
      );
}
