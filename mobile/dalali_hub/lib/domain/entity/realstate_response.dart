import 'dart:io';

import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';

class RealstateResponse extends Feed {

  RealstateResponse({
    required String id,
    required String title,
    required String category,
    required List<PhotoResponse> photos,
    required double minPrice,
    required double maxPrice,
    double? rooms,
    double? beds,
    double? baths,
    double? kitchens,
    required double size,
    required String sizeUnit,
    required List<String> otherFeatures,
    required String description,
    required bool isApproved,
    required Location location,
    int? seats,
  }) : super(
          id: id,
          photos: photos,
          location: location,
          category: category,
          title: title,
          description: description,
          isApproved: isApproved,
          minPrice: minPrice,
          maxPrice: maxPrice,
          rooms: rooms,
          beds: beds,
          baths: baths,
          kitchens: kitchens,
          size: size,
          sizeUnit: sizeUnit,
          otherFeatures: otherFeatures,
          seats: seats,
          
        );
}
