import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VehicleCard extends StatelessWidget {
  Function onTap;
  String? make;
  final String? location;
  final String? engineSize;
  final String? color;
  final String? year;
  final String? price;
  final String photo;
  VehicleCard({
    super.key,
    required this.onTap,
    this.make = "Toyota",
    this.location = "Heidenreich Forks Apt. 141 Kubton",
    this.engineSize = "5",
    this.color = "Black",
    this.year = "2001",
    this.price = "750,000",
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                  border: Border.all(color: AppColors.ultimateGray),
                  image: DecorationImage(
                      image: NetworkImage(photo), fit: BoxFit.cover)),
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
                    make!,
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
                        location!,
                        style: inputFieldHintStyle.copyWith(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Engine size",
                            style:
                                inputFieldHintStyle.copyWith(fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 1.3.w,
                          ),
                          Text(
                            "$engineSize ",
                            style:
                                inputFieldHintStyle.copyWith(fontSize: 12.sp),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Color",
                            style:
                                inputFieldHintStyle.copyWith(fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 1.3.w,
                          ),
                          Text(
                            "$color ",
                            style:
                                inputFieldHintStyle.copyWith(fontSize: 12.sp),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Year",
                            style:
                                inputFieldHintStyle.copyWith(fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 1.3.w,
                          ),
                          Text(
                            "$year ",
                            style:
                                inputFieldHintStyle.copyWith(fontSize: 12.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        price!,
                        style: inputFieldLabelMinStyle.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        "Birr",
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
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
