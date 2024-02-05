
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart';
import 'package:dalali_hub/data/remote/model/realm/room_wrapper.dart';

abstract class ChatRepository {
  Stream<void> sendMessage(String message, String roomId);
  Stream<List<Messages>> getMessages(String receiverId);
  Stream<List<RoomWrapper>> getRooms();
  Stream<void> createRoom(String receiverId);
  Stream<RoomWrapper> getRoom(String senderId, String receiverId);
}