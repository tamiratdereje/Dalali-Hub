


import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/feed_response_dto.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'favorite_client.g.dart';

@RestApi(baseUrl: 'api/v1/')
abstract class FavoriteClient {
  factory FavoriteClient(Dio dio, {String baseUrl}) = _FavoriteClient;


  @GET('favorites')
  Future<HttpResponse<JSendResponse<List<FeedResponseDto>>>>  getMyFavorites();

  @POST('favorites')
  Future<HttpResponse<JSendResponse<EmptyResponse>>> addToMyFavorite(@Body() Map<String, dynamic> propertyId);

  @DELETE("favorites/{propertyId}")
  Future<HttpResponse<JSendResponse<EmptyResponse>>> removeFromMyFavorite(@Path("propertyId") String propertyId);
  
}