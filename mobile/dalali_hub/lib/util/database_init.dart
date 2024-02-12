import 'package:dalali_hub/data/local/database/dalali_database.dart';

class AppDatabase {
  DalaliDatabase? _database;

  DalaliDatabase get database => _database!;


  AppDatabase._();

  static Future<AppDatabase> init() async {
    final appDatabase = AppDatabase._();

    appDatabase._database = await _getDatabase();

    return appDatabase;
  }

  static Future<DalaliDatabase> _getDatabase() async {
    final DalaliDatabase db = await $FloorDalaliDatabase
        .databaseBuilder('dalali_database.db')
        .build();
    return db;
  }
}
