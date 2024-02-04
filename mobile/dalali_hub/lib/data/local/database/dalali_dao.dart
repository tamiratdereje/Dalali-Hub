import 'package:dalali_hub/data/local/database/dalali_database.dart';
import 'package:dalali_hub/data/remote/model/user_response_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dalali_hub/data/remote/model/feed_response_dto.dart';

class DalaliDao {
  static Future<void> insertFeed(FeedResponseDto feed) async {
    final Database db = await DalaliDatabase.databaseInstance;

    await db.insert(
      'feeds',
      feed.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<FeedResponseDto>> getFeeds() async {
    final Database db = await DalaliDatabase.databaseInstance;

    final List<Map<String, dynamic>> maps = await db.query('feeds');

    return maps.map((e) => FeedResponseDto.fromJson(e)).toList();
  }

  static Future<void> deleteFeeds() async {
    final Database db = await DalaliDatabase.databaseInstance;

    await db.delete('feeds');
  }

  static Future<void> deleteOneFeed(String id) async {
    final Database db = await DalaliDatabase.databaseInstance;
    await db.delete('feeds', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> insertUser(UserResponseDto user) async {
    final Database db = await DalaliDatabase.databaseInstance;

    await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<UserResponseDto>> getUsers() async {
    final Database db = await DalaliDatabase.databaseInstance;

    final List<Map<String, dynamic>> maps = await db.query('users');

    return maps.map((e) => UserResponseDto.fromJson(e)).toList();
  }

  static Future<void> deleteUsers() async {
    final Database db = await DalaliDatabase.databaseInstance;

    await db.delete('users');
  }
}
