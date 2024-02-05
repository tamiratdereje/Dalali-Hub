import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/chat/bloc/get_rooms/get_rooms_bloc.dart';
import 'package:dalali_hub/app/pages/chat/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/data/remote/model/realm/room_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ContactScreem extends StatefulWidget {
  const ContactScreem({super.key});

  @override
  State<ContactScreem> createState() => _ContactScreemState();
}

class _ContactScreemState extends State<ContactScreem> {
  @override
  void initState() {
    super.initState();
    context.read<GetRoomsBloc>().add(const GetRoomsEvent.getRooms());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MessageAppBar(
          title: "Contact",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<GetRoomsBloc>()
                      .add(const GetRoomsEvent.getRooms());
                },
                color: AppColors.successColor,
                child: BlocConsumer<GetRoomsBloc, GetRoomsState>(
                  listener: (getRoomsContext, getRoomsState) {
                    getRoomsState.maybeWhen(
                      error: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
                      },
                      orElse: () {},
                    );
                  },
                  builder: (getRoomsContext, getRoomsState) {
                    return getRoomsState.maybeWhen(
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      success: (rooms) {
                        return rooms.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: rooms.length,
                                itemBuilder: (context, index) {
                                  return contactTile(context, rooms[index]);
                                },
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text("No Contacts Found"),
                                  ),
                                ],
                              );
                      },
                      error: (message) => Center(
                        child: Text(message),
                      ),
                      orElse: () => const Center(
                        child: Text("No Rooms"),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget contactTile(BuildContext context, RoomWrapper room) {
    var name = room.room.user1!.id.toString() == room.currentUserId
        ? "${room.room.user2!.firstName} ${room.room.user2!.sirName}"
        : "${room.room.user1!.firstName} ${room.room.user1!.sirName}";
    var email = room.room.user1!.id.toString() == room.currentUserId
        ? room.room.user2!.email
        : room.room.user1!.email;
    var unRead = room.room.user1!.id.toString() == room.currentUserId
        ? room.room.unred1!
        : room.room.unred2!;
    return GestureDetector(
      onTap: () => context.push(AppRoutes.chatRoom, extra: {
        "room": room,
      }),
      child: ListTile(
          leading:  CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueGrey,
            child: Text(name[0].toUpperCase(), style: const TextStyle(fontSize: 20, color: Colors.white),),
          ),
          title: Text(name),
          subtitle: Text(email!),
          trailing: unRead > 0
              ? Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    unRead <= 5 ? unRead.toString() : "5+",
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : const SizedBox.shrink()),
    );
  }
}
