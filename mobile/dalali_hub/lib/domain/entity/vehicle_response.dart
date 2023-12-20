import 'dart:io';

import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/entity/user_response.dart';

class VehicleResponse extends Feed {
  VehicleResponse({
    required String id,
    required String make,
    required String model,
    required List<PhotoResponse> photos,
    required int year,
    required String color,
    required String vin,
    required String fuelType,
    required int engineSize,
    required String transmissionType,
    required double mileage,
    required double price,
    required Location location,
    required String condition,
    required String category,
    required UserResponse owner,
    required bool isApproved,
    required int numberOfViews,
    bool? isFavorite,
  }) : super(
            id: id,
            photos: photos,
            location: location,
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
            category: category,
            owner: owner,
            isApproved: isApproved,
            numberOfViews: numberOfViews,
            isFavorite: isFavorite
            );
}
