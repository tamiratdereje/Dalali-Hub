import 'dart:io';

import 'package:dalali_hub/data/remote/client/realstate_client.dart';
import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/filter_parameter_dto.dart';
import 'package:dalali_hub/data/remote/model/realstate_dto.dart';
import 'package:dalali_hub/data/remote/model/realstate_response_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/filter_parameter.dart';
import 'package:dalali_hub/domain/entity/realstate.dart';
import 'package:dalali_hub/domain/entity/realstate_response.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/repository/realstate_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IRealstateRepository)
class RealstateRepository implements IRealstateRepository {
  final RealstateClient _realstateClient;

  RealstateRepository(this._realstateClient);

  @override
  Future<Resource<Empty>> addRealstate(Realstate realstate) async {
    var photosDto = realstate.photos.map((e) => File(e)).toList();

    var response = await handleApiCall<EmptyResponse>(
        _realstateClient.addRealstate(RealstateDto.toRealstateDto(realstate), photosDto));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

@override
  Future<Resource<List<RealstateResponse>>> getRealstates(FilterParameter filterParameter) async {
    
    Map<String, dynamic> map =
        FilterParameterDto.toFilterParameterDto(filterParameter).toJson();
    map.removeWhere((key, value) => value == null || value == '');
    debugPrint(map.toString());
    var response = await handleApiCall<List<RealstateResponseDto>>(
        _realstateClient.getRealstates(map));

    if (response is Success) {
      return Success(response.data!.map((e) => e.toRealstateResponse()).toList());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> deleteRealstate(String id) async {
    var response = await handleApiCall<Empty>(_realstateClient.deleteRealstate(id));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<RealstateResponse>> getRealstate(String id) async {
    var response =
        await handleApiCall<RealstateResponseDto>(_realstateClient.getRealstate(id));

    if (response is Success) {
      return Success(response.data!.toRealstateResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<RealstateResponse>> updateRealstate(Realstate realstate) async {
    var response = await handleApiCall<RealstateResponseDto>(
        _realstateClient.updateRealstate(realstate.id!, RealstateDto.toRealstateDto(realstate)));

    if (response is Success) {
      return Success(response.data!.toRealstateResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<PhotoResponse>> addRealstatePhotos(
      String realstateId, List<String> photos) async {
    var photosDto = photos.map((e) => File(e)).toList();

    var response = await handleApiCall<PhotoResponseDto>(
        _realstateClient.addRealstatePhotos(realstateId, photosDto));
    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> deleteRealstatePhoto(
      String realstateId, String photoId) async {
    var response = await handleApiCall<Empty>(
        _realstateClient.deleteRealstatePhoto(realstateId, photoId));

    if (response is Success) {
      return Success(response.data!);
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<PhotoResponse>> getRealstatePhotos(String realstateId) async {
    var response = await handleApiCall<PhotoResponseDto>(
        _realstateClient.getRealstatePhotos(realstateId));

    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }
}
