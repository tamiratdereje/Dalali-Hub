import 'package:dalali_hub/app/pages/chat/bloc/get_rooms/get_rooms_bloc.dart';
import 'package:dalali_hub/app/pages/chat/widgets/customer_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              BlocConsumer<GetRoomsBloc, GetRoomsState>(
                listener: (getRoomsContext, getRoomsState) {
                  // TODO: implement listener
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
                                return ListTile(
                                  title: Text(rooms[index].user1!.firstName!),
                                  subtitle:
                                      Text(rooms[index].user2!.firstName!),
                                );
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
              )
            ],
          ),
        ));
  }
}
