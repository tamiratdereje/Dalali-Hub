import 'dart:async';

import 'package:dalali_hub/data/local/database/dalali_database.dart';
import 'package:dalali_hub/data/remote/client/feed_client.dart';
import 'package:dalali_hub/data/remote/model/broker_stat_response_dto.dart';
import 'package:dalali_hub/data/remote/model/feed_response_dto.dart';
import 'package:dalali_hub/domain/entity/broker_stats.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/feed_repository.dart';
import 'package:dalali_hub/util/database_init.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFeedRepository)
class FeedRepository implements IFeedRepository {
  final FeedClient _feedClient;
  final AppDatabase _appDatabase;
  FeedRepository(this._feedClient, this._appDatabase);

  DalaliDatabase get database => _appDatabase.database;

  @override
  Stream<Resource<List<Feed>>> getAllFeeds() {
    final feedDao = database.feedDao;

    return feedDao.findAllFeeds().map(
          (event) => Success<List<Feed>>(
            event
                .map(
                  (e) => Feed.fromFeedEntity(e),
                )
                .toList(),
          ),
        );
  }

  @override
  Future<Resource<List<Feed>>> getAllFeedsFeeder() async {
    final feedDao = database.feedDao;

    var response =
        await handleApiCall<List<FeedResponseDto>>(_feedClient.getFeeds());

    if (response is Success) {
      List<Feed> newFeeds = response.data!.map((e) => e.toFeed()).toList();
      newFeeds.map(
        (e) {
          feedDao.insertFeed(e.toFeedEntity());
        },
      );

      return Success(newFeeds);
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Feed>> getProperty(String id) async {
    var response =
        await handleApiCall<FeedResponseDto>(_feedClient.getProperty(id));

    if (response is Success) {
      debugPrint(response.data!.price.toString());
      return Success(response.data!.toFeed());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<BrokerStat>> getMyStat() async {
    var response =
        await handleApiCall<BrokerStatResponseDto>(_feedClient.getMyStat());
    if (response is Success) {
      return Success(response.data!.toBrokerStat());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<List<Feed>>> getMyListing(bool? isApproved) async {
    Map<String, dynamic> filterParameter = {};
    if (isApproved != null) {
      filterParameter["isApproved"] = isApproved;
    }
    var response = await handleApiCall<List<FeedResponseDto>>(
        _feedClient.getMyListing(filterParameter));
    if (response is Success) {
      return Success(response.data!.map((e) => e.toFeed()).toList());
    } else {
      return Error(response.error!);
    }
  }
}
