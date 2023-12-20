import 'package:dalali_hub/data/remote/client/favorite_client.dart';
import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/feed_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/favorite_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFavoriteRepository)
class FavoriteRepository extends IFavoriteRepository {
  final FavoriteClient _favoriteClient;

  FavoriteRepository(this._favoriteClient);
  @override
  Future<Resource<Empty>> addToMyFavorite(String propertyId) async {
    var response = await handleApiCall<EmptyResponse>(
        _favoriteClient.addToMyFavorite({"property": propertyId}));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<List<Feed>>> getMyFavorites() async {
    var response = await handleApiCall<List<FeedResponseDto>>(
        _favoriteClient.getMyFavorites());

    if (response is Success) {
      return Success(response.data!.map((e) => e.toFeed()).toList());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> removeFromMyFavorite(String propertyId) async {
    debugPrint("propertyId: $propertyId");
    var response = await handleApiCall<EmptyResponse>(
        _favoriteClient.removeFromMyFavorite(propertyId));

    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }
}
