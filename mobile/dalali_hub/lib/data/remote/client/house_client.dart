import 'dart:convert';
import 'dart:io';

import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/house_dto.dart';
import 'package:dalali_hub/data/remote/model/house_response_dto.dart';
import 'package:dalali_hub/data/remote/model/location_dto.dart';
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
}
