import 'package:dalali_hub/app/pages/chat/bloc/get_messages/get_messages_bloc.dart';
import 'package:dalali_hub/app/pages/chat/bloc/send_message/send_message_bloc.dart';
import 'package:dalali_hub/app/pages/chat/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart';
import 'package:dalali_hub/data/remote/model/realm/room_wrapper.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:realm/realm.dart';

class ChatRoom extends StatelessWidget {
  RoomWrapper room;
  ChatRoom({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetMessagesBloc>(
          create: (context) => getIt<GetMessagesBloc>(),
        ),
        BlocProvider<SendMessageBloc>(
          create: (context) => getIt<SendMessageBloc>(),
        ),
      ],
      child: ChatRoomScreen(room: room),
    );
  }
}

class ChatRoomScreen extends StatefulWidget {
  RoomWrapper room;
  ChatRoomScreen({super.key, required this.room});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  List<types.Message> _messages = [];
  late final _user;
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _user = types.User(id: widget.room.currentUserId);
    context
        .read<GetMessagesBloc>()
        .add(GetMessagesEvent.getMessages(widget.room.room.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      
      appBar: MessageAppBar(
          canPop: true,
          title: widget.room.room.user1!.id.toString() ==
                  widget.room.currentUserId
              ? "${widget.room.room.user2!.firstName} ${widget.room.room.user2!.sirName}"
              : "${widget.room.room.user1!.firstName} ${widget.room.room.user1!.sirName}"),
      body: BlocListener<GetMessagesBloc, GetMessagesState>(
        listener: (getMessagesContext, getMessagesState) {
          getMessagesState.mapOrNull(
            success: (value) {
              setState(() {
                _messages = value.messages
                    .map((e) => types.TextMessage(
                          author: e.sender!.id.toString() ==
                                  widget.room.currentUserId
                              ? _user
                              : types.User(id: e.sender!.id.toString()),
                          id: e.id.toString(),
                          text: e.content!,
                          createdAt: e.createdAt!.millisecondsSinceEpoch,
                        ))
                    .toList();
              });
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.message),
                ),
              );
            },
          );
        },
        child: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: ObjectId().toString(),
      text: message.text,
    );
    _addMessage(textMessage);
    _context.read<SendMessageBloc>().add(SendMessageEvent.sendMessage(
        widget.room.room.id.toString(), message.text));
  }
}
