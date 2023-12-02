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
  Future<HttpResponse<JSendResponse<EmptyResponse>>> addHouse({
    @Part() String title,
    @Part() double minPrice,
    @Part() double maxPrice,
    @Part() double rooms,
    @Part() double beds,
    @Part() double baths,
    @Part() double kitchens,
    @Part() double size,
    @Part() String sizeUnit,
    @Part() List<String> otherFeatures,
    @Part() String description,
    @Part() bool isApproved,
    @Part() String category,
    @Part() List<File?> photos,

  });
}
