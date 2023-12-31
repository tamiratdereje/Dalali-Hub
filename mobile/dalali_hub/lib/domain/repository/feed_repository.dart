

import 'package:dalali_hub/domain/entity/broker_stats.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IFeedRepository {
  Future<Resource<List<Feed>>> getAllFeeds();
  Future<Resource<Feed>> getProperty(String id);
  Future<Resource<BrokerStat>> getMyStat();

}