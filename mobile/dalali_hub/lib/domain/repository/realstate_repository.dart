import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/house.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/entity/realstate.dart';
import 'package:dalali_hub/domain/entity/realstate_response.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IRealstateRepository {
  Future<Resource<RealstateResponse>> getRealstates();
  Future<Resource<Empty>> addRealstate(Realstate realstate);
  Future<Resource<RealstateResponse>> getRealstate(String id);
  Future<Resource<RealstateResponse>> updateRealstate(Realstate realstate);
  Future<Resource<Empty>> deleteRealstate(String id);

  Future<Resource<Empty>> deleteRealstatePhoto(String realstateId, String photoId);
  Future<Resource<PhotoResponse>> addRealstatePhotos(
      String realstateId, List<String> photos);
  Future<Resource<PhotoResponse>> getRealstatePhotos(String realstateId);
}
