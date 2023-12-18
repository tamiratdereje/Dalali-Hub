


import 'package:dalali_hub/data/remote/model/feed_response_dto.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'favorite_client.g.dart';

@RestApi(baseUrl: 'api/v1/')
abstract class FavoriteClient {
  factory FavoriteClient(Dio dio, {String baseUrl}) = _FavoriteClient;


  @GET('favorite')
  Future<HttpResponse<JSendResponse<List<FeedResponseDto>>>>  getMyFavorites();

  @POST('favorite')
  Future<HttpResponse<JSendResponse<FeedResponseDto>>> addToMyFavorite(@Body() String propertyId);

  @DELETE('favorite/propertyId')
  Future<HttpResponse<JSendResponse<Empty>>> removeFromMyFavorite(@Query("propertyId") String propertyId);
  
}