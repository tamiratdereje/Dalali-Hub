import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart'
    as realm_models;
import 'package:dalali_hub/data/remote/model/realm/room_wrapper.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/domain/repository/chat_repository.dart';
import 'package:dalali_hub/util/realm.config.dart';
import 'package:injectable/injectable.dart';
import 'package:realm/realm.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final App _app;
  final RealmConfig _realmConfig;
  final SharedPreference _sharedPreference;
  final IAuthRepository _authRepository;
  Realm get realm => _realmConfig.realm;

  ChatRepositoryImpl(this._realmConfig, this._app, this._sharedPreference,
      this._authRepository);
  @override
  Stream<void> createRoom(String receiverId) {
    // TODO: implement createRoom
    throw UnimplementedError();
  }

  Future<bool> loginToRealm() async {
    var user = _sharedPreference.getUserAuthDetails();
    var currentUser = _app.currentUser;
    if (user == null) {
      return false;
    }
    if (currentUser == null) {
      var credentials = Credentials.jwt(user.token);
      try {
        await _app.logIn(credentials);
        return true;
      } catch (e) {
        return false;
      }
    }
    return true;
  }

  @override
  Stream<List<realm_models.Messages>> getMessages(String roomId) async* {
    if (!(await loginToRealm())) {
      yield* Stream.error([]);
    }
    var room = realm.find<realm_models.Rooms>(ObjectId.fromHexString(roomId));
    var messages = realm.query<realm_models.Messages>(
        'room == \$0 SORT(createdAt DESC)', [room]);   
    yield* messages.changes.map((event) => event.results.toList());
  }

  @override
  Stream<List<RoomWrapper>> getRooms() async* {
    if (!(await loginToRealm())) {
      yield* Stream.error([]);
    }
    var userId = _sharedPreference.getUserAuthDetails()!.userId;

    var rooms = realm.query<realm_models.Rooms>(
        'totalMessages > 0 AND (user1.id = \$0 || user2.id = \$0) SORT(updatedAt DESC)',
        [ObjectId.fromHexString(userId)]);

    yield* rooms.changes
        .map((event) => event.results
            .map(
              (e) => RoomWrapper(currentUserId: userId, room: e),
            )
            .toList())
        .asBroadcastStream();
  }

  @override
  Stream<void> sendMessage(String content, String roomId) async* {
    if (!(await loginToRealm())) {
      yield* Stream.error([]);
    }
    yield* realm.write(() {
      var userId = _sharedPreference.getUserAuthDetails()!.userId;
      var sender =
          realm.find<realm_models.User>(ObjectId.fromHexString(userId));
      var room = realm.find<realm_models.Rooms>(ObjectId.fromHexString(roomId));

      realm.add<realm_models.Messages>(realm_models.Messages(
        ObjectId(),
        content: content,
        room: room,
        seen: false,
        sender: sender,
        createdAt: DateTime.now(),
      ));
      if (room!.user1!.id.toString() == sender!.id.toString()) {
        room.unred2 = (room.unred2 ?? 0) + 1;
      } else {
        room.unred1 = (room.unred1 ?? 0) + 1;
      }
      room.totalMessages = (room.totalMessages ?? 0) + 1;
      room.updatedAt = DateTime.now();
      return Stream.value(null);
    });
  }

  @override
  Stream<RoomWrapper> getRoom(String senderId, String receiverId) async* {
    if (!(await loginToRealm())) {
      yield* Stream.error([]);
    }
    var users = realm.all<realm_models.User>();
    var user1 = await users.changes
        .map((event) => event.results.firstWhere(
            (element) => element.id == ObjectId.fromHexString(senderId)))
        .first;
    var user2 = await users.changes
        .map((event) => event.results.firstWhere(
            (element) => element.id == ObjectId.fromHexString(receiverId)))
        .first;
    var room =
        realm.query<realm_models.Rooms>('user1 IN \$0 AND  user2 IN \$0', [
      [user1, user2]
    ]);
    if (room.isEmpty) {
      var room = realm.write(() {
        return realm.add<realm_models.Rooms>(realm_models.Rooms(
          ObjectId(),
          user1: user1,
          user2: user2,
          updatedAt: DateTime.now(),
          unred1: 0,
          unred2: 0,
          totalMessages: 0,
        ));
      });
      yield* Stream.value(RoomWrapper(currentUserId: senderId, room: room));
    }
    yield* room.changes.map((event) => event.results
        .map(
          (e) => RoomWrapper(currentUserId: senderId, room: e),
        )
        .first);
  }

  @override
  Stream<void> setMessagesSeen(String roomId) {
    var messages = realm.query<realm_models.Messages>(
        'room.id == \$0 AND seen == false', [ObjectId.fromHexString(roomId)]);
    return realm.write(() {
      for (var message in messages) {
        message.seen = true;
      }
      var room = realm.find<realm_models.Rooms>(ObjectId.fromHexString(roomId));
      var userId = _sharedPreference.getUserAuthDetails()!.userId;
      if (room!.user1!.id.toString() == userId) {
        room.unred1 = 0;
      } else {
        room.unred2 = 0;
      }
      return Stream.value(null);
    });
  }
}
