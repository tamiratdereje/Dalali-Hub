

import 'package:dalali_hub/data/remote/client/house_client.dart';
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
  Future<Resource<Empty>> addHouse(House house) {
    // TODO: implement addHouse
    throw UnimplementedError();
  }

  @override
  Future<Resource<HouseResponse>> getHouses() {
    // TODO: implement getHouses
    throw UnimplementedError();
  }

}