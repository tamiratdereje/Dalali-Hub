import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DalaliDatabase {
  static Future<Database> get databaseInstance async {
    return _dbInstance ??= await db();
  }

  static Database? _dbInstance;

  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dalali_database.db'),
      onCreate: (Database db, int version) async {
        await _createTables(db);
      },
      onUpgrade: (Database database, int oldVersion, int newVersion) async {
        // Handle database upgrades if needed
        debugPrint("Upgrading database");
        await database.execute("DROP TABLE IF EXISTS feeds");
        await database.execute("DROP TABLE IF EXISTS users");
        await database.execute("DROP TABLE IF EXISTS photos");
        await database.execute("DROP TABLE IF EXISTS locations");
        await _createTables(database);
      },
      onDowngrade: (database, oldVersion, newVersion) async {
        // Handle database downgrades if needed
        debugPrint("Downgrading database");
        await database.execute("DROP TABLE IF EXISTS feeds");
        await database.execute("DROP TABLE IF EXISTS users");
        await database.execute("DROP TABLE IF EXISTS photos");
        await database.execute("DROP TABLE IF EXISTS locations");
        await _createTables(database);
      },
      version: 1,
    );
  }

  static Future<void> _createTables(Database database) async {
    await database.execute('''DROP TABLE IF EXISTS feeds''');
    await database.execute('''DROP TABLE IF EXISTS users''');
    await database.execute('''DROP TABLE IF EXISTS photos''');
    await database.execute('''DROP TABLE IF EXISTS locations''');
    await database.execute('''PRAGMA foreign_keys = ON''');
    try {
      await database.execute('''
      CREATE TABLE feeds (
        id TEXT PRIMARY KEY,
        title TEXT,
        photos TEXT,
        rooms REAL,
        beds REAL,
        baths REAL,
        kitchens REAL,
        seats INTEGER,
        sizeWidth REAL,
        sizeHeight REAL,
        sizeUnit TEXT,
        otherFeatures TEXT,
        description TEXT,
        isApproved INTEGER,
        category TEXT,
        locationRegion TEXT,
        locationDistrict TEXT,
        locationWard TEXT,
        make TEXT,
        model TEXT,
        year INTEGER,
        color TEXT,
        vin TEXT,
        fuelType TEXT,
        engineSize INTEGER,
        transmissionType TEXT,
        mileage REAL,
        price REAL,
        condition TEXT,
        ownerId TEXT,
        numberOfViews INTEGER,
        isFavorite INTEGER
      )
    ''');

      await database.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        firstName TEXT,
        middleName TEXT,
        sirName TEXT,
        photos TEXT,
        email TEXT,
        phoneNumber TEXT,
        gender TEXT
      )
    ''');

      await database.execute('''
      CREATE TABLE photos (
        id TEXT PRIMARY KEY,
        publicId TEXT,
        secureUrl TEXT
      )
    ''');

      await database.execute('''
      CREATE TABLE locations (
        id TEXT PRIMARY KEY,
        region TEXT,
        district TEXT,
        ward TEXT
      )
    ''');
    } catch (e) {
      debugPrint("Error creating tables: $e");
    }
    debugPrint("Tables created");
    List<Map<String, dynamic>> tables = await database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'android%' AND name NOT LIKE 'sqlite%'");
    tables.forEach((table) async {
      List<Map<String, dynamic>> columns =
          await database.rawQuery("PRAGMA table_info('${table['name']}')");
      debugPrint("Table: ${table['name']}");
      for (var column in columns) {
        debugPrint("Column: ${column['name']} - ${column['type']}");
      }});
  }
}
