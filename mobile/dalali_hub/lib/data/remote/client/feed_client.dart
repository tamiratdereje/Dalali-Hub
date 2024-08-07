import 'package:dalali_hub/data/remote/model/broker_stat_response_dto.dart';
import 'package:dalali_hub/data/remote/model/feed_response_dto.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'feed_client.g.dart';

@RestApi(baseUrl: 'api/v1/')
abstract class FeedClient {
  factory FeedClient(Dio dio, {String baseUrl}) = _FeedClient;

  @GET('feed')
  Future<HttpResponse<JSendResponse<List<FeedResponseDto>>>> getFeeds();

  @GET('feed/{id}')
  Future<HttpResponse<JSendResponse<FeedResponseDto>>> getProperty(
      @Path('id') String id);

  @GET('feed/stat')
  Future<HttpResponse<JSendResponse<BrokerStatResponseDto>>> getMyStat();

  @GET('feed/mine')
  Future<HttpResponse<JSendResponse<List<FeedResponseDto>>>> getMyListing(
      @Query("filterParameter") Map<String, dynamic> filterParameter);
}
