
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/house.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IHouseRepository {
  Future<Resource<HouseResponse>> getHouses();
  Future<Resource<Empty>> addHouse(House house);
}