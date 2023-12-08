import 'dart:convert';
import 'dart:io';

import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dio/dio.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:retrofit/retrofit.dart';

part 'images_client.g.dart';

@RestApi(baseUrl: 'api/v1/')
abstract class ImagesClient {
  factory ImagesClient(Dio dio, {String baseUrl}) = _ImagesClient;

  @DELETE('property/{propertyId}/photos/{photoId}')
  Future<HttpResponse<JSendResponse<Empty>>> deletePropertyPhoto(
      @Path("propertyId") String propertyId, @Path("photoId") String photoId);

  @POST('property/{propertyId}/photos')
  @MultiPart()
  Future<HttpResponse<JSendResponse<PhotoResponseDto>>> addPropertyPhotos(
      @Path("propertyId") String propertyId, @Part(name: 'photos') List<File> photos);

  @GET("property/{propertyId}/photos")
  Future<HttpResponse<JSendResponse<PhotoResponseDto>>> getPropertyPhotos(
      @Path("propertyId") String propertyId);
}
