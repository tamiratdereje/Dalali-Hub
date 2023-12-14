// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedResponseDto _$FeedResponseDtoFromJson(Map<String, dynamic> json) =>
    FeedResponseDto(
      id: json['id'] as String,
      title: json['title'] as String?,
      category: json['category'] as String?,
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      rooms: (json['rooms'] as num?)?.toDouble(),
      beds: (json['beds'] as num?)?.toDouble(),
      baths: (json['baths'] as num?)?.toDouble(),
      kitchens: (json['kitchens'] as num?)?.toDouble(),
      seats: (json['seats'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toDouble(),
      sizeUnit: json['sizeUnit'] as String?,
      otherFeatures: (json['otherFeatures'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      isApproved: json['isApproved'] as bool?,
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
      make: json['make'] as String?,
      model: json['model'] as String?,
      year: json['year'] as int?,
      color: json['color'] as String?,
      vin: json['vin'] as String?,
      fuelType: json['fuelType'] as String?,
      engineSize: json['engineSize'] as int?,
      transmissionType: json['transmissionType'] as String?,
      mileage: (json['mileage'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      condition: json['condition'] as String?,
    );

Map<String, dynamic> _$FeedResponseDtoToJson(FeedResponseDto instance) =>
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
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'color': instance.color,
      'vin': instance.vin,
      'fuelType': instance.fuelType,
      'engineSize': instance.engineSize,
      'transmissionType': instance.transmissionType,
      'mileage': instance.mileage,
      'price': instance.price,
      'condition': instance.condition,
    };
