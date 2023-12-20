import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/data/remote/model/user_response_dto.dart';
import 'package:dalali_hub/domain/entity/realstate_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'realstate_response_dto.g.dart';

@JsonSerializable()
class RealstateResponseDto {
  final String id;
  final String title;
  final List<PhotoResponseDto> photos;
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
  final LocationDto location;
  final UserResponseDto owner;
  final int numberOfViews;
  bool? isFavorite;

  RealstateResponseDto({
    required this.title,
    required this.category,
    required this.id,
    required this.photos,
    required this.price,
    this.rooms,
    this.beds,
    this.baths,
    this.kitchens,
    this.seats,
    required this.sizeWidth,
    required this.sizeHeight,
    required this.sizeUnit,
    required this.otherFeatures,
    required this.description,
    required this.isApproved,
    required this.location,
    required this.owner,
    required this.numberOfViews,
    this.isFavorite,
  });

  factory RealstateResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RealstateResponseDtoFromJson(json);

  RealstateResponse toRealstateResponse() => RealstateResponse(
        title: title,
        category: category,
        id: id,
        photos: photos.map((e) => e.toPhotoResponse()).toList(),
        price: price,
        rooms: rooms,
        beds: beds,
        baths: baths,
        kitchens: kitchens,
        seats: seats,
        sizeWidth: sizeWidth,
        sizeHeight: sizeHeight,
        sizeUnit: sizeUnit,
        otherFeatures: otherFeatures,
        description: description,
        isApproved: isApproved,
        location: location.toLocation(),
        owner: owner.toUserResponse(),
        numberOfViews: numberOfViews,
        isFavorite: isFavorite,
      );
}
