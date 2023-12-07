import 'dart:convert';
import 'dart:io';

import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/house_dto.dart';
import 'package:dalali_hub/data/remote/model/house_response_dto.dart';
import 'package:dalali_hub/data/remote/model/location_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/house_response.dart';
import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dio/dio.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:retrofit/retrofit.dart';

part 'house_client.g.dart';

@RestApi(baseUrl: 'api/v1/')
abstract class HouseClient {
  factory HouseClient(Dio dio, {String baseUrl}) = _HouseClient;

  @GET('houses')
  Future<HttpResponse<JSendResponse<HouseResponseDto>>> getHouses();

  @POST('houses')
  @MultiPart()
  Future<HttpResponse<JSendResponse<EmptyResponse>>> addHouse(
    @Part(name: 'house') HouseDto house,
    @Part(name: 'photos') List<File> photos,
  );

  @PUT('houses/{id}')
  Future<HttpResponse<JSendResponse<HouseResponseDto>>> updateHouse(
    @Path("id") String id,
    @Body() HouseDto houseDto,
  );

  @DELETE('houses/{id}')
  Future<HttpResponse<JSendResponse<Empty>>> deleteHouse(
    @Path("id") String id,
  );

  @GET('houses/{id}')
  Future<HttpResponse<JSendResponse<HouseResponseDto>>> getHouse(
    @Path("id") String id,
  );

  @DELETE('houses/{houseId}/photos/{photoId}')
  Future<HttpResponse<JSendResponse<Empty>>> deleteHousePhoto(
      @Path("houseId") String houseId, @Path("photoId") String photoId);

  @POST('houses/{houseId}/photos')
  @MultiPart()
  Future<HttpResponse<JSendResponse<PhotoResponseDto>>> addHousePhotos(
      @Path("houseId") String houseId, @Part(name: 'photos') List<File> photos);

  @GET("houses/{houseId}/photos")
  Future<HttpResponse<JSendResponse<PhotoResponseDto>>> getHousePhotos(
      @Path("houseId") String houseId);
}
