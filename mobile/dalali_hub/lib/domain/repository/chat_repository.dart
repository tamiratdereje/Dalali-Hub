
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart';

abstract class ChatRepository {
  Stream<void> sendMessage(String message, String receiverId);
  Stream<List<Messages>> getMessages(String receiverId);
  Stream<List<Rooms>> getRooms();
  Stream<void> createRoom(String receiverId);
  Stream<Rooms> getRoom(String senderId, String receiverId);
}