import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class BrokerServiceContainer extends StatelessWidget {
  Function onTap;
  String serviceName;

  BrokerServiceContainer(
      {super.key, required this.onTap, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 25.6.w,
        padding: EdgeInsets.symmetric(horizontal: 2.6.w, vertical: 0.7.h),
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
