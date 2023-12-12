import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/house.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/entity/vehicle.dart';
import 'package:dalali_hub/domain/entity/vehicle_response.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IVehicleRepository {
  Future<Resource<VehicleResponse>> getVehicles();
  Future<Resource<Empty>> addVehicle(Vehicle vehicle);
  Future<Resource<VehicleResponse>> getVehicle(String id);
  Future<Resource<VehicleResponse>> updateVehicle(Vehicle vehicle);
  Future<Resource<Empty>> deleteVehicle(String id);

  Future<Resource<Empty>> deleteVehiclePhoto(String vehicleId, String photoId);
  Future<Resource<PhotoResponse>> addVehiclePhotos(
      String vehicleId, List<String> photos);
  Future<Resource<PhotoResponse>> getVehiclePhotos(String vehicleId);
}
