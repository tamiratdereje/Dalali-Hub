import 'dart:io';

import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/entity/user_response.dart';

class RealstateResponse extends Feed {
  RealstateResponse({
    required String id,
    required String title,
    required String category,
    required List<PhotoResponse> photos,
    required double price,
    double? rooms,
    double? beds,
    double? baths,
    double? kitchens,
    required double sizeWidth,
    required double sizeHeight,
    required String sizeUnit,
    required List<String> otherFeatures,
    required String description,
    required bool isApproved,
    required Location location,
    required UserResponse owner,
    required int numberOfViews,
    int? seats,
    bool? isFavorite,
  }) : super(
          id: id,
          photos: photos,
          location: location,
          category: category,
          title: title,
          description: description,
          isApproved: isApproved,
          price: price,
          rooms: rooms,
          beds: beds,
          baths: baths,
          kitchens: kitchens,
          sizeWidth: sizeWidth,
          sizeHeight: sizeHeight,
          sizeUnit: sizeUnit,
          otherFeatures: otherFeatures,
          seats: seats,
          owner: owner,
          numberOfViews: numberOfViews,
          isFavorite: isFavorite,
        );
}
