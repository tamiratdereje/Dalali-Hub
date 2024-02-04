import 'package:dalali_hub/data/remote/model/realm/realm_models.dart'
    as realm_models;
import 'package:dalali_hub/domain/repository/chat_repository.dart';
import 'package:dalali_hub/util/realm.config.dart';
import 'package:injectable/injectable.dart';
import 'package:realm/realm.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final App _app;
  final RealmConfig _realmConfig;
  Realm get realm => _realmConfig.realm;

  ChatRepositoryImpl(this._realmConfig, this._app);
  @override
  Stream<void> createRoom(String receiverId) {
    // TODO: implement createRoom
    throw UnimplementedError();
  }

  @override
  Stream<List<realm_models.Messages>> getMessages(String receiverId) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Stream<List<realm_models.Rooms>> getRooms() {
    var rooms = realm.all<realm_models.Rooms>();
    return rooms.changes.map((event) => event.results.toList());
  }

  @override
  Stream<void> sendMessage(String message, String receiverId) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Stream<realm_models.Rooms> getRoom(String senderId, String receiverId) async* {
    var users = realm.all<realm_models.User>();
    var user1 = await users.changes.map((event) => event.results.firstWhere(
        (element) => element.id == ObjectId.fromHexString(senderId))).first;
    var user2 = await users.changes.map((event) => event.results.firstWhere(
        (element) => element.id == ObjectId.fromHexString(receiverId))).first;
    print('user1: $user1');
    print('user2: $user2');
    var room =
        realm.query<realm_models.Rooms>('user1 IN \$0 AND  user2 IN \$0', [
      [user1, user2]
    ]);
    if (room.isEmpty) {
      yield* Stream.value(realm.write(() {
        return realm.add<realm_models.Rooms>(realm_models.Rooms(
          ObjectId(),
          user1: user1,
          user2: user2,
          updatedAt: DateTime.now(),
        ));
      }));
    }
    yield* room.changes.map((event) => event.results.first);
  }
}
