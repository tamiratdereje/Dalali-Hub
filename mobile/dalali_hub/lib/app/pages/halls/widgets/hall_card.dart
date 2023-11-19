import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HallCard extends StatelessWidget {
  const HallCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.7.h, left: 0.1.w, right: 0.1.w),
      padding: EdgeInsets.symmetric(horizontal: 2.6.w, vertical: 1.1.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(2.6.w),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            blurRadius: 2,
            offset: Offset(.8, .8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 26.6.w,
            height: 11.5.h,
            decoration: BoxDecoration(
                color: AppColors.nauticalCreatures,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.ultimateGray)),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: const Icon(
                      Icons.heart_broken,
                      size: 15,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          SizedBox(
            width: 50.6.w,
            height: 11.5.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Abrehot Hall",
                  style: boldbodyTextStyle,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 12,
                      color: AppColors.nauticalCreatures,
                    ),
                    SizedBox(
                      width: 1.8.w,
                    ),
                    Text(
                      "Abrehot Hall Arat kilo, 3 floor",
                      style: inputFieldHintStyle.copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.people_outline_outlined,
                          size: 12,
                          color: AppColors.nauticalCreatures,
                        ),
                        SizedBox(
                          width: 1.3.w,
                        ),
                        Text(
                          "2000 people",
                          style: inputFieldHintStyle.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.bathtub_outlined,
                          size: 12,
                          color: AppColors.nauticalCreatures,
                        ),
                        SizedBox(
                          width: 1.3.w,
                        ),
                        Text(
                          "2 Baths",
                          style: inputFieldHintStyle.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_box_outline_blank_outlined,
                          size: 12,
                          color: AppColors.nauticalCreatures,
                        ),
                        SizedBox(
                          width: 1.3.w,
                        ),
                        Text(
                          "2400 SQ FT",
                          style: inputFieldHintStyle.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "150",
                      style: inputFieldLabelMinStyle.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "/hr",
                      style: inputFieldLabelMinStyle.copyWith(
                          color: AppColors.buttonContainerWatermarkColor,
                          fontSize: 12.sp),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
