// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dalali_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDalaliDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DalaliDatabaseBuilder databaseBuilder(String name) =>
      _$DalaliDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DalaliDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$DalaliDatabaseBuilder(null);
}

class _$DalaliDatabaseBuilder {
  _$DalaliDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DalaliDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DalaliDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DalaliDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DalaliDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DalaliDatabase extends DalaliDatabase {
  _$DalaliDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FeedDao? _feedDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FeedEntity` (`id` TEXT NOT NULL, `title` TEXT, `photos` TEXT NOT NULL, `rooms` REAL, `beds` REAL, `baths` REAL, `kitchens` REAL, `seats` INTEGER, `sizeWidth` REAL, `sizeHeight` REAL, `sizeUnit` TEXT, `otherFeatures` TEXT, `description` TEXT, `isApproved` INTEGER, `category` TEXT, `locationId` INTEGER, `make` TEXT, `model` TEXT, `year` INTEGER, `color` TEXT, `vin` TEXT, `fuelType` TEXT, `engineSize` INTEGER, `transmissionType` TEXT, `mileage` REAL, `price` REAL, `condition` TEXT, `owner` TEXT NOT NULL, `numberOfViews` INTEGER NOT NULL, `isFavorite` INTEGER, FOREIGN KEY (`locationId`) REFERENCES `LocationEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`owner`) REFERENCES `UserEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PhotoEntity` (`id` TEXT NOT NULL, `publicUrl` TEXT NOT NULL, `secoureUrl` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LocationEntity` (`region` TEXT PRIMARY KEY AUTOINCREMENT NOT NULL, `district` TEXT NOT NULL, `ward` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserEntity` (`id` TEXT NOT NULL, `firstName` TEXT NOT NULL, `middleName` TEXT NOT NULL, `sirName` TEXT NOT NULL, `photo` TEXT NOT NULL, `email` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL, `gender` TEXT NOT NULL, FOREIGN KEY (`photo`) REFERENCES `PhotoEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FeedDao get feedDao {
    return _feedDaoInstance ??= _$FeedDao(database, changeListener);
  }
}

class _$FeedDao extends FeedDao {
  _$FeedDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _feedEntityInsertionAdapter = InsertionAdapter(
            database,
            'FeedEntity',
            (FeedEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'photos': item.photos,
                  'rooms': item.rooms,
                  'beds': item.beds,
                  'baths': item.baths,
                  'kitchens': item.kitchens,
                  'seats': item.seats,
                  'sizeWidth': item.sizeWidth,
                  'sizeHeight': item.sizeHeight,
                  'sizeUnit': item.sizeUnit,
                  'otherFeatures': item.otherFeatures,
                  'description': item.description,
                  'isApproved': item.isApproved == null
                      ? null
                      : (item.isApproved! ? 1 : 0),
                  'category': item.category,
                  'locationId': item.locationId,
                  'make': item.make,
                  'model': item.model,
                  'year': item.year,
                  'color': item.color,
                  'vin': item.vin,
                  'fuelType': item.fuelType,
                  'engineSize': item.engineSize,
                  'transmissionType': item.transmissionType,
                  'mileage': item.mileage,
                  'price': item.price,
                  'condition': item.condition,
                  'owner': item.owner,
                  'numberOfViews': item.numberOfViews,
                  'isFavorite': item.isFavorite == null
                      ? null
                      : (item.isFavorite! ? 1 : 0)
                },
            changeListener),
        _feedEntityUpdateAdapter = UpdateAdapter(
            database,
            'FeedEntity',
            ['id'],
            (FeedEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'photos': item.photos,
                  'rooms': item.rooms,
                  'beds': item.beds,
                  'baths': item.baths,
                  'kitchens': item.kitchens,
                  'seats': item.seats,
                  'sizeWidth': item.sizeWidth,
                  'sizeHeight': item.sizeHeight,
                  'sizeUnit': item.sizeUnit,
                  'otherFeatures': item.otherFeatures,
                  'description': item.description,
                  'isApproved': item.isApproved == null
                      ? null
                      : (item.isApproved! ? 1 : 0),
                  'category': item.category,
                  'locationId': item.locationId,
                  'make': item.make,
                  'model': item.model,
                  'year': item.year,
                  'color': item.color,
                  'vin': item.vin,
                  'fuelType': item.fuelType,
                  'engineSize': item.engineSize,
                  'transmissionType': item.transmissionType,
                  'mileage': item.mileage,
                  'price': item.price,
                  'condition': item.condition,
                  'owner': item.owner,
                  'numberOfViews': item.numberOfViews,
                  'isFavorite': item.isFavorite == null
                      ? null
                      : (item.isFavorite! ? 1 : 0)
                },
            changeListener),
        _feedEntityDeletionAdapter = DeletionAdapter(
            database,
            'FeedEntity',
            ['id'],
            (FeedEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'photos': item.photos,
                  'rooms': item.rooms,
                  'beds': item.beds,
                  'baths': item.baths,
                  'kitchens': item.kitchens,
                  'seats': item.seats,
                  'sizeWidth': item.sizeWidth,
                  'sizeHeight': item.sizeHeight,
                  'sizeUnit': item.sizeUnit,
                  'otherFeatures': item.otherFeatures,
                  'description': item.description,
                  'isApproved': item.isApproved == null
                      ? null
                      : (item.isApproved! ? 1 : 0),
                  'category': item.category,
                  'locationId': item.locationId,
                  'make': item.make,
                  'model': item.model,
                  'year': item.year,
                  'color': item.color,
                  'vin': item.vin,
                  'fuelType': item.fuelType,
                  'engineSize': item.engineSize,
                  'transmissionType': item.transmissionType,
                  'mileage': item.mileage,
                  'price': item.price,
                  'condition': item.condition,
                  'owner': item.owner,
                  'numberOfViews': item.numberOfViews,
                  'isFavorite': item.isFavorite == null
                      ? null
                      : (item.isFavorite! ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FeedEntity> _feedEntityInsertionAdapter;

  final UpdateAdapter<FeedEntity> _feedEntityUpdateAdapter;

  final DeletionAdapter<FeedEntity> _feedEntityDeletionAdapter;

  @override
  Stream<List<FeedEntity>> findAllFeeds() {
    return _queryAdapter.queryListStream('SELECT * FROM FeedEntity',
        mapper: (Map<String, Object?> row) => FeedEntity(
            id: row['id'] as String,
            title: row['title'] as String?,
            category: row['category'] as String?,
            photos: row['photos'] as String,
            rooms: row['rooms'] as double?,
            beds: row['beds'] as double?,
            baths: row['baths'] as double?,
            kitchens: row['kitchens'] as double?,
            seats: row['seats'] as int?,
            sizeWidth: row['sizeWidth'] as double?,
            sizeHeight: row['sizeHeight'] as double?,
            sizeUnit: row['sizeUnit'] as String?,
            otherFeatures: row['otherFeatures'] as String?,
            description: row['description'] as String?,
            isApproved: row['isApproved'] == null
                ? null
                : (row['isApproved'] as int) != 0,
            locationId: row['locationId'] as int?,
            make: row['make'] as String?,
            model: row['model'] as String?,
            year: row['year'] as int?,
            color: row['color'] as String?,
            vin: row['vin'] as String?,
            fuelType: row['fuelType'] as String?,
            engineSize: row['engineSize'] as int?,
            transmissionType: row['transmissionType'] as String?,
            mileage: row['mileage'] as double?,
            price: row['price'] as double?,
            condition: row['condition'] as String?,
            owner: row['owner'] as String,
            numberOfViews: row['numberOfViews'] as int,
            isFavorite: row['isFavorite'] == null
                ? null
                : (row['isFavorite'] as int) != 0),
        queryableName: 'FeedEntity',
        isView: false);
  }

  @override
  Future<void> insertFeed(FeedEntity feedEntity) async {
    await _feedEntityInsertionAdapter.insert(
        feedEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFeed(FeedEntity feedEntity) async {
    await _feedEntityUpdateAdapter.update(feedEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFeed(FeedEntity feedEntity) async {
    await _feedEntityDeletionAdapter.delete(feedEntity);
  }
}
