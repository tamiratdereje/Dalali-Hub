

import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IFeedRepository {
  Future<Resource<List<Feed>>> getAllFeeds();
}