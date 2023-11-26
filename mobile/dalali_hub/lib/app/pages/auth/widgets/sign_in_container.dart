
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SingInContainer extends StatelessWidget {
  String icon;
  String title;
  Function tap;
 
  Color color;
  SingInContainer(
      {super.key,
      required this.title,
      required this.icon,
      required this.tap,
     
      this.color = AppColors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.avatorBackground,
              radius: 10.w,
              child: Image.asset(icon),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              title,
              style: buttonContainerWatermarkStyle.copyWith(fontSize: 16, color: AppColors.semiBoldContainerColor),
            ),
          ],
        ),
      ),
      onTap: () {
        tap();
      },
    );
  }
}
