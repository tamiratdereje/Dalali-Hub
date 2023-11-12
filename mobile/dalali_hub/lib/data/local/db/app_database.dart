import 'dart:async';

import 'package:dalali_hub/data/local/db/model/test.dart';
import 'package:floor/floor.dart';
import 'package:dalali_hub/data/local/db/dao/test_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [TestEntity])
abstract class AppDatabase extends FloorDatabase {

  TestDao get testDao;

}