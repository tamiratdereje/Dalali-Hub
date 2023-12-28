import 'dart:io';

import 'package:dalali_hub/data/remote/client/images_client.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/repository/images_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IImagesRepository)
class ImagesRepository implements IImagesRepository {
  final ImagesClient _imagesClient;

  ImagesRepository(this._imagesClient);

  @override
  Future<Resource<List<PhotoResponse>>> addPhotos(
      String propertyId, List<String> photos, String propertyName) async {
    var photosDto = photos.map((e) => File(e)).toList();

    var response = await handleApiCall<List<PhotoResponseDto>>(
        _imagesClient.addPropertyPhotos(propertyId, photosDto, propertyName));
    if (response is Success) {
      return Success(response.data!.map((e) => e.toPhotoResponse()).toList());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<PhotoResponse>> deletePhoto(
      String propertyId, String photoId, String propertyName) async {
    debugPrint("$propertyId $photoId $propertyName ");
    var response = await handleApiCall<PhotoResponseDto>(
        _imagesClient.deletePropertyPhoto(propertyId, photoId, propertyName));

    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<PhotoResponse>> getPhotos(
      String propertyId, String propertyName) async {
    var response = await handleApiCall<PhotoResponseDto>(
        _imagesClient.getPropertyPhotos(propertyId, propertyName));

    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }
}
