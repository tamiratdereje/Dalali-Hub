// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Messages extends _Messages
    with RealmEntity, RealmObjectBase, RealmObject {
  Messages(
    ObjectId id, {
    String? content,
    DateTime? createdAt,
    Rooms? room,
    bool? seen,
    User? sender,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'room', room);
    RealmObjectBase.set(this, 'seen', seen);
    RealmObjectBase.set(this, 'sender', sender);
  }

  Messages._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get content =>
      RealmObjectBase.get<String>(this, 'content') as String?;
  @override
  set content(String? value) => RealmObjectBase.set(this, 'content', value);

  @override
  DateTime? get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime?;
  @override
  set createdAt(DateTime? value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  Rooms? get room => RealmObjectBase.get<Rooms>(this, 'room') as Rooms?;
  @override
  set room(covariant Rooms? value) => RealmObjectBase.set(this, 'room', value);

  @override
  bool? get seen => RealmObjectBase.get<bool>(this, 'seen') as bool?;
  @override
  set seen(bool? value) => RealmObjectBase.set(this, 'seen', value);

  @override
  User? get sender => RealmObjectBase.get<User>(this, 'sender') as User?;
  @override
  set sender(covariant User? value) =>
      RealmObjectBase.set(this, 'sender', value);

  @override
  Stream<RealmObjectChanges<Messages>> get changes =>
      RealmObjectBase.getChanges<Messages>(this);

  @override
  Messages freeze() => RealmObjectBase.freezeObject<Messages>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Messages._);
    return const SchemaObject(ObjectType.realmObject, Messages, 'messages', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('content', RealmPropertyType.string, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('room', RealmPropertyType.object,
          optional: true, linkTarget: 'rooms'),
      SchemaProperty('seen', RealmPropertyType.bool, optional: true),
      SchemaProperty('sender', RealmPropertyType.object,
          optional: true, linkTarget: 'user'),
    ]);
  }
}

class Photo extends _Photo with RealmEntity, RealmObjectBase, RealmObject {
  Photo(
    ObjectId id, {
    int? v,
    DateTime? createdAt,
    String? publicId,
    String? secureUrl,
    DateTime? updatedAt,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, '__v', v);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'publicId', publicId);
    RealmObjectBase.set(this, 'secureUrl', secureUrl);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  Photo._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  int? get v => RealmObjectBase.get<int>(this, '__v') as int?;
  @override
  set v(int? value) => RealmObjectBase.set(this, '__v', value);

  @override
  DateTime? get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime?;
  @override
  set createdAt(DateTime? value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  String? get publicId =>
      RealmObjectBase.get<String>(this, 'publicId') as String?;
  @override
  set publicId(String? value) => RealmObjectBase.set(this, 'publicId', value);

  @override
  String? get secureUrl =>
      RealmObjectBase.get<String>(this, 'secureUrl') as String?;
  @override
  set secureUrl(String? value) => RealmObjectBase.set(this, 'secureUrl', value);

  @override
  DateTime? get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime?;
  @override
  set updatedAt(DateTime? value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<Photo>> get changes =>
      RealmObjectBase.getChanges<Photo>(this);

  @override
  Photo freeze() => RealmObjectBase.freezeObject<Photo>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Photo._);
    return const SchemaObject(ObjectType.realmObject, Photo, 'photo', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('v', RealmPropertyType.int, mapTo: '__v', optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('publicId', RealmPropertyType.string, optional: true),
      SchemaProperty('secureUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }
}

class Rooms extends _Rooms with RealmEntity, RealmObjectBase, RealmObject {
  Rooms(
    ObjectId id, {
    int? unred1,
    int? unred2,
    DateTime? updatedAt,
    User? user1,
    User? user2,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'unred1', unred1);
    RealmObjectBase.set(this, 'unred2', unred2);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
    RealmObjectBase.set(this, 'user1', user1);
    RealmObjectBase.set(this, 'user2', user2);
  }

  Rooms._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  int? get unred1 => RealmObjectBase.get<int>(this, 'unred1') as int?;
  @override
  set unred1(int? value) => RealmObjectBase.set(this, 'unred1', value);

  @override
  int? get unred2 => RealmObjectBase.get<int>(this, 'unred2') as int?;
  @override
  set unred2(int? value) => RealmObjectBase.set(this, 'unred2', value);

  @override
  DateTime? get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime?;
  @override
  set updatedAt(DateTime? value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  User? get user1 => RealmObjectBase.get<User>(this, 'user1') as User?;
  @override
  set user1(covariant User? value) => RealmObjectBase.set(this, 'user1', value);

  @override
  User? get user2 => RealmObjectBase.get<User>(this, 'user2') as User?;
  @override
  set user2(covariant User? value) => RealmObjectBase.set(this, 'user2', value);

  @override
  Stream<RealmObjectChanges<Rooms>> get changes =>
      RealmObjectBase.getChanges<Rooms>(this);

  @override
  Rooms freeze() => RealmObjectBase.freezeObject<Rooms>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Rooms._);
    return const SchemaObject(ObjectType.realmObject, Rooms, 'rooms', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('unred1', RealmPropertyType.int, optional: true),
      SchemaProperty('unred2', RealmPropertyType.int, optional: true),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('user1', RealmPropertyType.object,
          optional: true, linkTarget: 'user'),
      SchemaProperty('user2', RealmPropertyType.object,
          optional: true, linkTarget: 'user'),
    ]);
  }
}

class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  User(
    ObjectId id, {
    int? v,
    DateTime? createdAt,
    String? email,
    String? firstName,
    String? gender,
    bool? isVerified,
    String? middleName,
    String? password,
    String? phoneNumber,
    String? region,
    String? role,
    String? sirName,
    DateTime? updatedAt,
    Iterable<ObjectId> photos = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, '__v', v);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'isVerified', isVerified);
    RealmObjectBase.set(this, 'middleName', middleName);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'phoneNumber', phoneNumber);
    RealmObjectBase.set(this, 'region', region);
    RealmObjectBase.set(this, 'role', role);
    RealmObjectBase.set(this, 'sirName', sirName);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
    RealmObjectBase.set<RealmList<ObjectId>>(
        this, 'photos', RealmList<ObjectId>(photos));
  }

  User._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  int? get v => RealmObjectBase.get<int>(this, '__v') as int?;
  @override
  set v(int? value) => RealmObjectBase.set(this, '__v', value);

  @override
  DateTime? get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime?;
  @override
  set createdAt(DateTime? value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => RealmObjectBase.set(this, 'email', value);

  @override
  String? get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String?;
  @override
  set firstName(String? value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String? get gender => RealmObjectBase.get<String>(this, 'gender') as String?;
  @override
  set gender(String? value) => RealmObjectBase.set(this, 'gender', value);

  @override
  bool? get isVerified =>
      RealmObjectBase.get<bool>(this, 'isVerified') as bool?;
  @override
  set isVerified(bool? value) => RealmObjectBase.set(this, 'isVerified', value);

  @override
  String? get middleName =>
      RealmObjectBase.get<String>(this, 'middleName') as String?;
  @override
  set middleName(String? value) =>
      RealmObjectBase.set(this, 'middleName', value);

  @override
  String? get password =>
      RealmObjectBase.get<String>(this, 'password') as String?;
  @override
  set password(String? value) => RealmObjectBase.set(this, 'password', value);

  @override
  String? get phoneNumber =>
      RealmObjectBase.get<String>(this, 'phoneNumber') as String?;
  @override
  set phoneNumber(String? value) =>
      RealmObjectBase.set(this, 'phoneNumber', value);

  @override
  RealmList<ObjectId> get photos =>
      RealmObjectBase.get<ObjectId>(this, 'photos') as RealmList<ObjectId>;
  @override
  set photos(covariant RealmList<ObjectId> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get region => RealmObjectBase.get<String>(this, 'region') as String?;
  @override
  set region(String? value) => RealmObjectBase.set(this, 'region', value);

  @override
  String? get role => RealmObjectBase.get<String>(this, 'role') as String?;
  @override
  set role(String? value) => RealmObjectBase.set(this, 'role', value);

  @override
  String? get sirName =>
      RealmObjectBase.get<String>(this, 'sirName') as String?;
  @override
  set sirName(String? value) => RealmObjectBase.set(this, 'sirName', value);

  @override
  DateTime? get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime?;
  @override
  set updatedAt(DateTime? value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(User._);
    return const SchemaObject(ObjectType.realmObject, User, 'user', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('v', RealmPropertyType.int, mapTo: '__v', optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('firstName', RealmPropertyType.string, optional: true),
      SchemaProperty('gender', RealmPropertyType.string, optional: true),
      SchemaProperty('isVerified', RealmPropertyType.bool, optional: true),
      SchemaProperty('middleName', RealmPropertyType.string, optional: true),
      SchemaProperty('password', RealmPropertyType.string, optional: true),
      SchemaProperty('phoneNumber', RealmPropertyType.string, optional: true),
      SchemaProperty('photos', RealmPropertyType.objectid,
          collectionType: RealmCollectionType.list),
      SchemaProperty('region', RealmPropertyType.string, optional: true),
      SchemaProperty('role', RealmPropertyType.string, optional: true),
      SchemaProperty('sirName', RealmPropertyType.string, optional: true),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }
}
