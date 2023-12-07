import 'dart:io';

import 'package:dalali_hub/data/remote/client/house_client.dart';
import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/house_dto.dart';
import 'package:dalali_hub/data/remote/model/house_response_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/house.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/repository/house_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IHouseRepository)
class HouseRepository implements IHouseRepository {
  final HouseClient _houseClient;

  HouseRepository(this._houseClient);

  @override
  Future<Resource<Empty>> addHouse(House house) async {
    var photosDto = house.photos.map((e) => File(e)).toList();

    var response = await handleApiCall<EmptyResponse>(
        _houseClient.addHouse(HouseDto.toHouseDto(house), photosDto));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<HouseResponse>> getHouses() {
    // TODO: implement getHouses for Abel
    throw UnimplementedError();
  }

  @override
  Future<Resource<Empty>> deleteHouse(String id) async {
    var response = await handleApiCall<Empty>(_houseClient.deleteHouse(id));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<HouseResponse>> getHouse(String id) async {
    var response =
        await handleApiCall<HouseResponseDto>(_houseClient.getHouse(id));

    if (response is Success) {
      return Success(response.data!.toHouseResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<HouseResponse>> updateHouse(House house) async {
    var response = await handleApiCall<HouseResponseDto>(
        _houseClient.updateHouse(house.id!, HouseDto.toHouseDto(house)));

    if (response is Success) {
      return Success(response.data!.toHouseResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<PhotoResponse>> addHousePhotos(
      String houseId, List<String> photos) async {
    var photosDto = photos.map((e) => File(e)).toList();

    var response = await handleApiCall<PhotoResponseDto>(
        _houseClient.addHousePhotos(houseId, photosDto));
    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> deleteHousePhoto(
      String houseId, String photoId) async {
    var response = await handleApiCall<Empty>(
        _houseClient.deleteHousePhoto(houseId, photoId));

    if (response is Success) {
      return Success(response.data!);
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<PhotoResponse>> getHousePhotos(String houseId) async {
    var response = await handleApiCall<PhotoResponseDto>(
        _houseClient.getHousePhotos(houseId));

    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }
}
