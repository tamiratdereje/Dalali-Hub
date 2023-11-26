import 'package:dalali_hub/app/pages/chat/widgets/customer_appbar.dart';
import 'package:flutter/material.dart';

class ContactScreem extends StatefulWidget {
  const ContactScreem({super.key});

  @override
  State<ContactScreem> createState() => _ContactScreemState();
}

class _ContactScreemState extends State<ContactScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessageAppBar(
        title: "Contact",
      ),
      body : SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: ((context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueGrey,
                ),
                title: const Text("Dr. John Doe"),
                subtitle: const Text("Dentist"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                ),
              );
            }),)

          ],
        ),
      )
    );
  }
}