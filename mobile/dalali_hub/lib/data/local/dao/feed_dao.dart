
import 'package:dalali_hub/data/local/entities/feed_db_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class FeedDao {

  @Query('SELECT * FROM FeedEntity')
  Stream<List<FeedEntity>> findAllFeeds();

  @insert
  Future<void> insertFeed(FeedEntity feedEntity);

  @update
  Future<void> updateFeed(FeedEntity feedEntity);

  @delete
  Future<void> deleteFeed(FeedEntity feedEntity);

  
}