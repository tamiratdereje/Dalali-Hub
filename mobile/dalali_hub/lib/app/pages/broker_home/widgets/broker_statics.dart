
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BrokerStatics extends StatelessWidget {
  String amount;
  String activity;
  Function onTap;
  BrokerStatics({
    super.key,
    required this.amount,
    required this.activity,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 28.8.w,
        height: 10.3.h,
        padding:
            EdgeInsets.symmetric(horizontal: 3.2.w, vertical: 1.1.h),
        decoration: BoxDecoration(
          color: AppColors.dividerLineSemiBoldColor,
          borderRadius: BorderRadius.all(
            Radius.elliptical(28.8.w, 10.3.h),
          ),
          border: Border.all(
            color: AppColors.nauticalCreatures,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              amount,
              style: bodyTextStyle,
            ),
            Text(
              activity,
              style: categoryContainerStyle.copyWith(
                  color: AppColors.nauticalCreatures),
                  overflow: TextOverflow.visible,
                  maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
