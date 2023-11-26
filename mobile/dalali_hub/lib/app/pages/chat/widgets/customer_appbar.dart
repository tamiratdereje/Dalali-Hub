import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class MessageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  String title;
  bool isCenter;
  Color? color= AppColors.doctor.withOpacity(0.0);
  MessageAppBar({super.key, required this.title, this.isCenter = false, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3.7.h, left: 8.8.w),
      
      child: Row(
        children: [
          Container(
            width: 10.6.w,
            height: 4.6.h,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.ultimateGray)),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_sharp,
                size: 15,
              ),
            ),
          ),
          SizedBox(
            width: !isCenter ? 4.8.w : 23.3.w,
          ),
          Text(
            title,
            style: appBarTitleStyle,
          ),
          
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
