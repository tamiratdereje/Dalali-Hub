import 'package:dalali_hub/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ForgotPasswordAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  String title;
  ForgotPasswordAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(Icons.arrow_back_ios_sharp),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        Text(title),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
