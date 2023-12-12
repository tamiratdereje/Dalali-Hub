import 'dart:convert';
import 'dart:io';

import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/house_dto.dart';
import 'package:dalali_hub/data/remote/model/house_response_dto.dart';
import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/data/remote/model/realstate_dto.dart';
import 'package:dalali_hub/data/remote/model/realstate_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dio/dio.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:retrofit/retrofit.dart';

part 'realstate_client.g.dart';

@RestApi(baseUrl: 'api/v1/')
abstract class RealstateClient {
  factory RealstateClient(Dio dio, {String baseUrl}) = _RealstateClient;

  @GET('realstates')
  Future<HttpResponse<JSendResponse<RealstateResponseDto>>> getRealstates();

  @POST('realstates')
  @MultiPart()
  Future<HttpResponse<JSendResponse<EmptyResponse>>> addRealstate(
    @Part(name: 'realstate') RealstateDto realstate,
    @Part(name: 'photos') List<File> photos,
  );

  @PUT('realstates/{id}')
  Future<HttpResponse<JSendResponse<RealstateResponseDto>>> updateRealstate(
    @Path("id") String id,
    @Body() RealstateDto realstateDto,
  );

  @DELETE('realstates/{id}')
  Future<HttpResponse<JSendResponse<Empty>>> deleteRealstate(
    @Path("id") String id,
  );

  @GET('realstates/{id}')
  Future<HttpResponse<JSendResponse<RealstateResponseDto>>> getRealstate(
    @Path("id") String id,
  );

  @DELETE('realstates/{realstateId}/photos/{photoId}')
  Future<HttpResponse<JSendResponse<Empty>>> deleteRealstatePhoto(
      @Path("realstateId") String realstateId, @Path("photoId") String photoId);

  @POST('realstates/{realstateId}/photos')
  @MultiPart()
  Future<HttpResponse<JSendResponse<PhotoResponseDto>>> addRealstatePhotos(
      @Path("realstateId") String realstateId, @Part(name: 'photos') List<File> photos);

  @GET("realstates/{RealstateId}/photos")
  Future<HttpResponse<JSendResponse<PhotoResponseDto>>> getRealstatePhotos(
      @Path("realstateId") String realstateId);
}
