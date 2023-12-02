

import 'package:dalali_hub/domain/entity/location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_dto.g.dart';
@JsonSerializable(explicitToJson: true)
class LocationDto {
  final String region;
  final String district;
  final String ward;

  LocationDto({
    required this.region,
    required this.district,
    required this.ward,
  
  });
  factory LocationDto.fromLocation(Location location) {
    return LocationDto(
      region: location.region,
      district: location.district,
      ward: location.ward,
    );
  } 
  Location toLocation() => Location(
    region: region,
    district: district,
    ward: ward,
  );

  factory LocationDto.fromJson(Map<String, dynamic> json) => _$LocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);


}