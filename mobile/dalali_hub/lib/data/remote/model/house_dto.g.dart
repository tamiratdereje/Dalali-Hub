// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseDto _$HouseDtoFromJson(Map<String, dynamic> json) => HouseDto(
      title: json['title'] as String,
      category: json['category'] as String,
      minPrice: (json['minPrice'] as num).toDouble(),
      maxPrice: (json['maxPrice'] as num).toDouble(),
      rooms: (json['rooms'] as num).toDouble(),
      beds: (json['beds'] as num).toDouble(),
      baths: (json['baths'] as num).toDouble(),
      kitchens: (json['kitchens'] as num).toDouble(),
      size: (json['size'] as num).toDouble(),
      sizeUnit: json['sizeUnit'] as String,
      otherFeatures: (json['otherFeatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      isApproved: json['isApproved'] as bool,
      id: json['id'] as String?,
      location: json['location'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$HouseDtoToJson(HouseDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'rooms': instance.rooms,
      'beds': instance.beds,
      'baths': instance.baths,
      'kitchens': instance.kitchens,
      'size': instance.size,
      'sizeUnit': instance.sizeUnit,
      'otherFeatures': instance.otherFeatures,
      'description': instance.description,
      'isApproved': instance.isApproved,
      'category': instance.category,
      'location': instance.location,
    };
