import 'dart:io';

import 'package:dalali_hub/data/remote/client/images_client.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/repository/images_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IImagesRepository)
class ImagesRepository implements IImagesRepository {
  final ImagesClient _imagesClient;

  ImagesRepository(this._imagesClient);

  
  @override
  Future<Resource<PhotoResponse>> addPhotos(String propertyId, List<String> photos) async {
    var photosDto = photos.map((e) => File(e)).toList();

    var response = await handleApiCall<PhotoResponseDto>(
        _imagesClient.addPropertyPhotos(propertyId, photosDto));
    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }
  
  @override
  Future<Resource<Empty>> deletePhoto(String propertyId, String photoId) async {
    var response = await handleApiCall<Empty>(
        _imagesClient.deletePropertyPhoto(propertyId, photoId));

    if (response is Success) {
      return Success(response.data!);
    } else {
      return Error(response.error!);
    }
  }
  
  @override
  Future<Resource<PhotoResponse>> getPhotos(String propertyId) async {
    var response = await handleApiCall<PhotoResponseDto>(
        _imagesClient.getPropertyPhotos(propertyId));

    if (response is Success) {
      return Success(response.data!.toPhotoResponse());
    } else {
      return Error(response.error!);
    }
  }
}
