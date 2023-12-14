import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class CustomerServiceContainer extends StatelessWidget {
  Function onTap;
  String serviceName;

  CustomerServiceContainer(
      {super.key, required this.onTap, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 40.w,
        padding: EdgeInsets.symmetric(horizontal: 3.1.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: AppColors.nauticalCreatures,
          borderRadius: BorderRadius.all(
            Radius.circular(2.6.w),
          ),
        ),
        child: Text(
          serviceName,
          style: categoryContainerStyle,
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
