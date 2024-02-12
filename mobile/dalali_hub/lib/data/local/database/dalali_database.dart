import 'dart:async';

import 'package:dalali_hub/data/local/dao/feed_dao.dart';
import 'package:dalali_hub/data/local/entities/feed_db_entity.dart';
import 'package:dalali_hub/data/local/entities/location_db_entity.dart';
import 'package:dalali_hub/data/local/entities/photo_db_entity.dart';
import 'package:dalali_hub/data/local/entities/user_db_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'dalali_database.g.dart';

@Database(
    version: 1, entities: [FeedEntity, PhotoEntity, LocationEntity, UserEntity])
abstract class DalaliDatabase extends FloorDatabase {
  FeedDao get feedDao;
}
