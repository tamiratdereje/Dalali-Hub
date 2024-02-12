

import 'package:dalali_hub/domain/entity/broker_stats.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IFeedRepository {
  Stream<Resource<List<Feed>>> getAllFeeds();
  Future<Resource<List<Feed>>> getAllFeedsFeeder();
  Future<Resource<Feed>> getProperty(String id);
  Future<Resource<BrokerStat>> getMyStat();
  Future<Resource<List<Feed>>> getMyListing(bool? isApproved);
}