import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResultItemCard extends StatelessWidget {
  const ResultItemCard(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.color,
      required this.onTap,
      required this.feed})
      : super(key: key);

  final String imgUrl;
  final String title;
  final Color color;
  final Function onTap;
  final Feed feed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
        margin: EdgeInsets.only(bottom: 1.8.h, right: 1.8.w),
        width: 37.w,
        height: 23.2.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 12.h,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(feed.photos[0].secoureUrl),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 1.h),
            SizedBox(
              height: 10.9.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feed.category!,
                    style: bodyTextStyle.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        feed.location.region,
                        style: buttonContainerWatermarkStyle.copyWith(
                            fontSize: 12.sp),
                      ),
                      if (feed.category == "House for rent" ||
                          feed.category == "House for sell" ||
                          feed.category == "Long stay apartment" ||
                          feed.category == "Office")
                        Text(
                          "No of rooms: ${feed.rooms}",
                          style: buttonContainerWatermarkStyle.copyWith(
                              fontSize: 12.sp),
                        ),
                      if (feed.category == "Land")
                        Text(
                          "Size: ${(feed.sizeWidth ?? 1) * (feed.sizeHeight ?? 1)} sqm",
                          style: buttonContainerWatermarkStyle.copyWith(
                              fontSize: 12.sp),
                        ),
                      if (feed.category == "Hall")
                        Text(
                          "Seats: ${feed.seats}",
                          style: buttonContainerWatermarkStyle.copyWith(
                              fontSize: 12.sp),
                        ),
                      if (feed.category == "Vehicle")
                        Text(
                          "Make: ${feed.make}",
                          style: buttonContainerWatermarkStyle.copyWith(
                              fontSize: 12.sp),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        feed.location.district,
                        style: buttonContainerWatermarkStyle.copyWith(
                            fontSize: 12.sp),
                      ),
                      if (feed.category == "Vehicle")
                        Text(
                          "Years: ${feed.year}",
                          style: buttonContainerWatermarkStyle.copyWith(
                              fontSize: 12.sp),
                        ),
                    ],
                  ),
                  Text(
                    feed.location.ward,
                    style:
                        buttonContainerWatermarkStyle.copyWith(fontSize: 12.sp),
                  ),
                  Text("${feed.price ?? feed.price} Tsh",
                      style: bodyTextStyle.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.w700)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
