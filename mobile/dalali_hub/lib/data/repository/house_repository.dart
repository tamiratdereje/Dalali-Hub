import 'dart:io';

import 'package:dalali_hub/data/remote/client/house_client.dart';
import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/house.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:dalali_hub/domain/repository/house_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IHouseRepository)
class HouseRepository implements IHouseRepository {
  final HouseClient _houseClient;

  HouseRepository(this._houseClient);

  @override
  Future<Resource<Empty>> addHouse(House house) async {
    var houseDto = {
      'title': house.title,
      'minPrice': house.minPrice,
      'maxPrice': house.maxPrice,
      'rooms': house.rooms,
      'beds': house.beds,
      'baths': house.baths,
      'kitchens': house.kitchens,
      'size': house.size,
      'sizeUnit': house.sizeUnit,
      'otherFeatures': house.otherFeatures,
      'description': house.description,
      'isApproved': false,
      'category': house.category,
      'location': {
        'region': house.location.region,
        'ward': house.location.ward,
        'district': house.location.district
      },
    };

    var photosDto = house.photos.map((e) => File(e)).toList();

    var response = await handleApiCall<EmptyResponse>(
        _houseClient.addHouse(houseDto, photosDto));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<HouseResponse>> getHouses() {
    // TODO: implement getHouses
    throw UnimplementedError();
  }
}
