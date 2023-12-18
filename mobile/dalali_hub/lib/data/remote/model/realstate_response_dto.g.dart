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
      price: (json['price'] as num).toDouble(),
      rooms: (json['rooms'] as num?)?.toDouble(),
      beds: (json['beds'] as num?)?.toDouble(),
      baths: (json['baths'] as num?)?.toDouble(),
      kitchens: (json['kitchens'] as num?)?.toDouble(),
      seats: json['seats'] as int?,
      sizeWidth: (json['sizeWidth'] as num).toDouble(),
      sizeHeight: (json['sizeHeight'] as num).toDouble(),
      sizeUnit: json['sizeUnit'] as String,
      otherFeatures: (json['otherFeatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      isApproved: json['isApproved'] as bool,
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
      owner: UserResponseDto.fromJson(json['owner'] as Map<String, dynamic>),
      numberOfViews: json['numberOfViews'] as int,
    );

Map<String, dynamic> _$RealstateResponseDtoToJson(
        RealstateResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'photos': instance.photos,
      'price': instance.price,
      'rooms': instance.rooms,
      'beds': instance.beds,
      'baths': instance.baths,
      'kitchens': instance.kitchens,
      'seats': instance.seats,
      'sizeWidth': instance.sizeWidth,
      'sizeHeight': instance.sizeHeight,
      'sizeUnit': instance.sizeUnit,
      'otherFeatures': instance.otherFeatures,
      'description': instance.description,
      'isApproved': instance.isApproved,
      'category': instance.category,
      'location': instance.location,
      'owner': instance.owner,
      'numberOfViews': instance.numberOfViews,
    };
