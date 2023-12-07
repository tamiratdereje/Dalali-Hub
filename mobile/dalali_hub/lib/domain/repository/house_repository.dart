import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/house.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IHouseRepository {
  Future<Resource<HouseResponse>> getHouses();
  Future<Resource<Empty>> addHouse(House house);
  Future<Resource<HouseResponse>> getHouse(String id);
  Future<Resource<HouseResponse>> updateHouse(House house);
  Future<Resource<Empty>> deleteHouse(String id);

  Future<Resource<Empty>> deleteHousePhoto(String houseId, String photoId);
  Future<Resource<PhotoResponse>> addHousePhotos(
      String houseId, List<String> photos);
  Future<Resource<PhotoResponse>> getHousePhotos(String houseId);
}
