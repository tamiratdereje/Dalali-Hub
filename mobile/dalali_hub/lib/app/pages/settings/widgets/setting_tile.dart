import 'package:dalali_hub/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingTile extends StatelessWidget {
  final Icon icon;
  final String title;
  final Function onTap;
  const SettingTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.selectedContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}

class SettingTileList extends StatelessWidget {
  const SettingTileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingTile(
          icon: Icon(Icons.person),
          title: 'Profile',
          onTap: () {},
        ),
        SizedBox(height: 2.h),
        SettingTile(
          icon: Icon(Icons.notifications),
          title: 'Notifications',
          onTap: () {},
        ),
        SizedBox(height: 2.h),
        SettingTile(
          icon: Icon(Icons.lock),
          title: 'Privacy',
          onTap: () {},
        ),
        SizedBox(height: 2.h),
        SettingTile(
          icon: Icon(Icons.help),
          title: 'Help',
          onTap: () {},
        ),
        SizedBox(height: 2.h),
        SettingTile(
          icon: Icon(Icons.info),
          title: 'About',
          onTap: () {},
        ),
        SizedBox(height: 4.h),
        
      ],
    );
  }
}
