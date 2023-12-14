// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realstate_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealstateResponseDto _$RealstateResponseDtoFromJson(
        Map<String, dynamic> json) =>
    RealstateResponseDto(
      title: json['title'] as String,
      category: json['category'] as String,
      id: json['id'] as String,
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      minPrice: (json['minPrice'] as num).toDouble(),
      maxPrice: (json['maxPrice'] as num).toDouble(),
      rooms: (json['rooms'] as num?)?.toDouble(),
      beds: (json['beds'] as num?)?.toDouble(),
      baths: (json['baths'] as num?)?.toDouble(),
      kitchens: (json['kitchens'] as num?)?.toDouble(),
      seats: json['seats'] as int?,
      size: (json['size'] as num).toDouble(),
      sizeUnit: json['sizeUnit'] as String,
      otherFeatures: (json['otherFeatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      isApproved: json['isApproved'] as bool,
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RealstateResponseDtoToJson(
        RealstateResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'photos': instance.photos,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'rooms': instance.rooms,
      'beds': instance.beds,
      'baths': instance.baths,
      'kitchens': instance.kitchens,
      'seats': instance.seats,
      'size': instance.size,
      'sizeUnit': instance.sizeUnit,
      'otherFeatures': instance.otherFeatures,
      'description': instance.description,
      'isApproved': instance.isApproved,
      'category': instance.category,
      'location': instance.location,
    };