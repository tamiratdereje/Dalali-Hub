// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realstate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealstateDto _$RealstateDtoFromJson(Map<String, dynamic> json) => RealstateDto(
      title: json['title'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      rooms: (json['rooms'] as num?)?.toDouble(),
      beds: (json['beds'] as num?)?.toDouble(),
      baths: (json['baths'] as num?)?.toDouble(),
      kitchens: (json['kitchens'] as num?)?.toDouble(),
      sizeWidth: (json['sizeWidth'] as num).toDouble(),
      sizeHeight: (json['sizeHeight'] as num).toDouble(),
      sizeUnit: json['sizeUnit'] as String,
      otherFeatures: (json['otherFeatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      isApproved: json['isApproved'] as bool,
      id: json['id'] as String?,
      location: json['location'] as Map<String, dynamic>,
      seats: json['seats'] as int?,
    );

Map<String, dynamic> _$RealstateDtoToJson(RealstateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'rooms': instance.rooms,
      'beds': instance.beds,
      'baths': instance.baths,
      'kitchens': instance.kitchens,
      'sizeWidth': instance.sizeWidth,
      'sizeHeight': instance.sizeHeight,
      'sizeUnit': instance.sizeUnit,
      'otherFeatures': instance.otherFeatures,
      'description': instance.description,
      'isApproved': instance.isApproved,
      'category': instance.category,
      'location': instance.location,
      'seats': instance.seats,
    };
