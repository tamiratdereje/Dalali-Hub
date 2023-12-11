

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

}