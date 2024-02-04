import 'package:realm/realm.dart';
part 'realm_models.g.dart';

// NOTE: These models are private and therefore should be copied into the same .dart file.

@RealmModel()
@MapTo('messages')
class _Messages {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  String? content;

  bool? read;

  _Rooms? room;
}

@RealmModel()
@MapTo('photo')
class _Photo {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('__v')
  int? v;

  DateTime? createdAt;

  String? publicId;

  String? secureUrl;

  DateTime? updatedAt;
}

@RealmModel()
@MapTo('rooms')
class _Rooms {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  int? unred;

  DateTime? updatedAt;

  _User? user1;

  _User? user2;
}

@RealmModel()
@MapTo('user')
class _User {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('__v')
  int? v;

  DateTime? createdAt;

  String? email;

  String? firstName;

  String? gender;

  bool? isVerified;

  String? middleName;

  String? password;

  String? phoneNumber;

  late List<ObjectId> photos;

  String? region;

  String? role;

  String? sirName;

  DateTime? updatedAt;
}
