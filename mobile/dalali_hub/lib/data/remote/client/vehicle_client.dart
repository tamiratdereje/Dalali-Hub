import 'dart:convert';
import 'dart:io';

import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/filter_parameter_dto.dart';
import 'package:dalali_hub/data/remote/model/vehicle_dto.dart';
import 'package:dalali_hub/data/remote/model/vehicle_response_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/filter_parameter.dart';
import 'package:dio/dio.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:retrofit/retrofit.dart';

part 'vehicle_client.g.dart';

@RestApi(baseUrl: 'api/v1/')
abstract class VehicleClient {
  factory VehicleClient(Dio dio, {String baseUrl}) = _VehicleClient;

  @GET('vehicles/all')
  Future<HttpResponse<JSendResponse<List<VehicleResponseDto>>>> getVehicles(
    @Query('filterParameter') Map<String, dynamic> filterParameter,
  );

  @POST('vehicles')
  @MultiPart()
  Future<HttpResponse<JSendResponse<EmptyResponse>>> addVehicle(
    @Part(name: 'vehicle') VehicleDto vehicle,
    @Part(name: 'photos') List<File> photos,
  );

  @PUT('vehicles/{id}')
  Future<HttpResponse<JSendResponse<VehicleResponseDto>>> updateVehicle(
    @Path("id") String id,
    @Body() VehicleDto vehicleDto,
  );

  @DELETE('vehicles/{id}')
  Future<HttpResponse<JSendResponse<EmptyResponse>>> deleteVehicle(
    @Path("id") String id,
  );

  @GET('vehicles/{id}')
  Future<HttpResponse<JSendResponse<VehicleResponseDto>>> getVehicle(
    @Path("id") String id,
  );

  @DELETE('vehicles/{vehicleId}/photos/{photoId}')
  Future<HttpResponse<JSendResponse<Empty>>> deleteVehiclePhoto(
      @Path("vehicleId") String vehicleId, @Path("photoId") String photoId);

  @POST('vehicles/{vehicleId}/photos')
  @MultiPart()
  Future<HttpResponse<JSendResponse<PhotoResponseDto>>> addVehiclePhotos(
      @Path("vehicleId") String vehicleId, @Part(name: 'photos') List<File> photos);

  @GET("vehicles/{vehicleId}/photos")
  Future<HttpResponse<JSendResponse<PhotoResponseDto>>> getVehiclePhotos(
      @Path("vehicleId") String vehicleId);
}
