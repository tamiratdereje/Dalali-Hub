import 'package:dalali_hub/data/remote/model/realm/realm_models.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  Rooms room;

  ChatRoom({super.key, required this.room});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
