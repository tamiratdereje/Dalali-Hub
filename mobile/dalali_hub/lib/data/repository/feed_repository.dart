import 'package:dalali_hub/data/remote/client/feed_client.dart';
import 'package:dalali_hub/data/remote/model/feed_response_dto.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/feed_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';

@LazySingleton(as: IFeedRepository)
class FeedRepository implements IFeedRepository {
  final FeedClient _feedClient;

  FeedRepository(this._feedClient);

  @override
  Future<Resource<List<Feed>>> getAllFeeds() async {
    var response =
        await handleApiCall<List<FeedResponseDto>>(_feedClient.getFeeds());

    if (response is Success) {
      return Success(response.data!.map((e) => e.toFeed()).toList());
    } else {
      return Error(response.error!);
    }
  }
  
  @override
  Future<Resource<Feed>> getProperty(String id) async {
   var response =
        await handleApiCall<FeedResponseDto>(_feedClient.getProperty(id));

    if (response is Success) {
      return Success(response.data!.toFeed());
    } else {
      return Error(response.error!);
    }
  }
}
