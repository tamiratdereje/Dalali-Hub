

import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IFavoriteRepository {
  Future<Resource<List<Feed>>> getMyFavorites();
  Future<Resource<Empty>> addToMyFavorite(String propertyId);
  Future<Resource<Empty>> removeFromMyFavorite(String propertyId);
}