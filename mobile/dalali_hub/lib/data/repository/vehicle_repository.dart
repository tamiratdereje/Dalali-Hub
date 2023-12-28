import 'dart:io';

import 'package:dalali_hub/data/remote/client/vehicle_client.dart';
import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/filter_parameter_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/data/remote/model/vehicle_dto.dart';
import 'package:dalali_hub/data/remote/model/vehicle_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/filter_parameter.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/entity/vehicle.dart';
import 'package:dalali_hub/domain/entity/vehicle_response.dart';
import 'package:dalali_hub/domain/repository/vehicle_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IVehicleRepository)
class VehicleRepository implements IVehicleRepository {
  final VehicleClient _vehicleClient;

  VehicleRepository(this._vehicleClient);

  @override
  Future<Resource<Empty>> addVehicle(Vehicle vehicle) async {
    var photosDto = vehicle.photos.map((e) => File(e)).toList();

    var response = await handleApiCall<EmptyResponse>(
        _vehicleClient.addVehicle(VehicleDto.toVehicleDto(vehicle), photosDto));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<List<VehicleResponse>>> getVehicles(
      FilterParameter filterParameter) async {

    Map<String, dynamic> map =
        FilterParameterDto.toFilterParameterDto(filterParameter).toJson();
    map.removeWhere((key, value) => value == null || value == '');

    var response = await handleApiCall<List<VehicleResponseDto>>(
        _vehicleClient.getVehicles(map));

    if (response is Success) {
      return Success(response.data!.map((e) => e.toVehicleResponse()).toList());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> deleteVehicle(String id) async {
    var response = await handleApiCall<EmptyResponse>(_vehicleClient.deleteVehicle(id));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<VehicleResponse>> getVehicle(String id) async {
    var response =
        await handleApiCall<VehicleResponseDto>(_vehicleClient.getVehicle(id));

    if (response is Success) {
      return Success(response.data!.toVehicleResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<VehicleResponse>> updateVehicle(Vehicle vehicle) async {
    var response = await handleApiCall<VehicleResponseDto>(_vehicleClient
        .updateVehicle(vehicle.id!, VehicleDto.toVehicleDto(vehicle)));

    if (response is Success) {
      return Success(response.data!.toVehicleResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<PhotoResponse>> addVehiclePhotos(
      String VehicleId, List<String> photos) async {
    var photosDto = photos.map((e) => File(e)).toList();

    var response = await handleApiCall<PhotoResponseDto>(
        _vehicleClient.addVehiclePhotos(VehicleId, photosDto));
    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> deleteVehiclePhoto(
      String VehicleId, String photoId) async {
    var response = await handleApiCall<Empty>(
        _vehicleClient.deleteVehiclePhoto(VehicleId, photoId));

    if (response is Success) {
      return Success(response.data!);
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<PhotoResponse>> getVehiclePhotos(String VehicleId) async {
    var response = await handleApiCall<PhotoResponseDto>(
        _vehicleClient.getVehiclePhotos(VehicleId));

    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }
}
