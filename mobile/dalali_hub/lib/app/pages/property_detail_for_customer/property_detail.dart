import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/broker_home/widgets/broker_service_container.dart';
import 'package:dalali_hub/app/pages/broker_home/widgets/broker_statics.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PropertyDetailPage extends StatefulWidget {
  const PropertyDetailPage({super.key});

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomerAppBar(
        title: "Property Detail",
        color: AppColors.doctor.withOpacity(0.5),
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
            left: 6.6.w, right: 6.6.w, bottom: 5.6.h, top: 1.9.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 42.5.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  image: const DecorationImage(
                    image: AssetImage(
                      ImageConstants.detailApartmentImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 2.7.h,
              ),
              Text("Duplex Apartment", style: appBarTitleStyle),
              SizedBox(
                height: 3.7.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price",
                    style: inputFieldLabelStyle,
                  ),
                  Text(
                    "NPR 1,00,00,000",
                    style: inputFieldLabelMinStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 1.7.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bed_rounded,
                        size: 20,
                        color: AppColors.nauticalCreatures,
                      ),
                      SizedBox(
                        width: 3.3.w,
                      ),
                      Text(
                        "4 Beds",
                        style: inputFieldHintStyle.copyWith(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.7.h,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.bathtub_outlined,
                        size: 20,
                        color: AppColors.nauticalCreatures,
                      ),
                      SizedBox(
                        width: 3.3.w,
                      ),
                      Text(
                        "2 Baths",
                        style: inputFieldHintStyle.copyWith(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 1.7.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.check_box_outline_blank_outlined,
                    size: 20,
                    color: AppColors.nauticalCreatures,
                  ),
                  SizedBox(
                    width: 3.3.w,
                  ),
                  Text(
                    "2400 SQ FT",
                    style: inputFieldHintStyle.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 3.7.h,
              ),
              Text(
                "Location of the house",
                style: bodyTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              SizedBox(
                height: 1.3.h,
              ),
              Container(
                margin:
                    EdgeInsets.only(bottom: 1.7.h, left: 0.1.w, right: 0.1.w),
                padding:
                    EdgeInsets.symmetric(horizontal: 2.6.w, vertical: 1.1.h),
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Region:",
                          style: inputFieldLabelStyle,
                        ),
                        SizedBox(
                          width: 16.3.w,
                        ),
                        Text(
                          "Singida",
                          style: inputFieldLabelMinStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.7.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "District:",
                          style: inputFieldLabelStyle,
                        ),
                        SizedBox(
                          width: 16.3.w,
                        ),
                        Text(
                          "Manyoni",
                          style: inputFieldLabelMinStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.7.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Wards:",
                          style: inputFieldLabelStyle,
                        ),
                        SizedBox(
                          width: 16.3.w,
                        ),
                        Text(
                          "Sungusia",
                          style: inputFieldLabelMinStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.7.h,
                    ),
                  ],
                ),
              ),
              Text(
                "Add other features",
                style: bodyTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              SizedBox(
                height: 1.8.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 3.7.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.3.w),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.07),
                      // spreadRadius: 13,
                      blurRadius: 13,
                      offset: Offset(3, 3), // changes position of shadow
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FacilitiesItemCreate(),
                        Container(
                          width: 1,
                          height: 2.3.h,
                          color: AppColors.dividerLineSemiBoldColor,
                        ),
                        FacilitiesItemCreate(),
                        Container(
                          width: 1,
                          height: 2.3.h,
                          color: AppColors.dividerLineSemiBoldColor,
                        ),
                        FacilitiesItemCreate()
                      ],
                    ),
                    SizedBox(
                      height: 1.8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 5.3.w,
                          height: .2.h,
                          color: AppColors.dividerLineSemiBoldColor,
                        ),
                        Container(
                          width: 5.3.w,
                          height: .2.h,
                          color: AppColors.dividerLineSemiBoldColor,
                        ),
                        Container(
                          width: 5.3.w,
                          height: .2.h,
                          color: AppColors.dividerLineSemiBoldColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FacilitiesItemCreate(),
                        Container(
                          width: 1,
                          height: 2.3.h,
                          color: AppColors.dividerLineSemiBoldColor,
                        ),
                        FacilitiesItemCreate(),
                        Container(
                          width: 1,
                          height: 2.3.h,
                          color: AppColors.dividerLineSemiBoldColor,
                        ),
                        FacilitiesItemCreate()
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.7.h,
              ),
              Text(
                "Description",
                style: bodyTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              SizedBox(
                height: 1.3.h,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Sed euismod, diam sit amet dictum aliquam, "
                "nunc nisl aliquet enim, vitae aliquam nisl nunc vitae "
                "nunc. Sed euismod, diam sit amet dictum aliquam, "
                "nunc nisl aliquet enim, vitae aliquam nisl nunc vitae "
                "nunc. Sed euismod, diam sit amet dictum aliquam, "
                "nunc nisl aliquet enim, vitae aliquam nisl nunc vitae "
                "nunc. Sed euismod, diam sit amet dictum aliquam, "
                "nunc nisl aliquet enim, vitae aliquam nisl nunc vitae "
                "nunc. Sed euismod, diam sit amet dictum aliquam, "
                "nunc nisl aliquet enim, vitae aliquam nisl nunc vitae "
                "nunc. Sed euismod, diam sit amet dictum aliquam, "
                "nunc nisl aliquet enim, vitae aliquam nisl nunc vitae "
                "nunc. Sed euismod, diam sit amet dictum aliquam, "
                "nunc nisl aliquet enim, vitae aliquam nisl nunc vitae "
                "nunc. Sed euismod, diam sit amet dictum aliquam, "
                "nunc nisl aliquet enim, vitae aliquam nisl nunc vitae "
                "nunc. ",
                style: inputFieldHintStyle.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                height: 1.7.h,
              ),
              Text(
                "Contact Broker",
                style: bodyTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              SizedBox(
                height: 1.7.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 3.7.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.3.w),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.07),
                      // spreadRadius: 13,
                      blurRadius: 13,
                      offset: Offset(3, 3), // changes position of shadow
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10.6.w,
                          height: 10.6.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(
                                ImageConstants.detailApartmentImage,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.7.w,
                        ),
                        Text(
                          "Manuel Collins",
                          style: inputFieldLabelStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 9.3.w,
                          height: 3.9.h,
                          decoration: const BoxDecoration(
                              color: AppColors.nauticalCreatures,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.phone,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(
                          width: 1.8.w,
                        ),
                        Container(
                          width: 9.3.w,
                          height: 3.9.h,
                          decoration: const BoxDecoration(
                              color: AppColors.selectedContainer,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.message,
                            color: AppColors.nauticalCreatures,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.7.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pictures",
                    style: bodyTextStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    "Show all pictures",
                    style: linkTextStylePrimary.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 2.2.h,
              ),
              SizedBox(
                height: 8.4.h,
                child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 2.6.w),
                        width: 19.7.w,
                        height: 8.4.h,
                        decoration: BoxDecoration(
                            color: AppColors.buttonContainerWatermarkColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.5.w))),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column FacilitiesItemCreate() {
    return Column(
      children: [
        const Icon(Icons.wifi),
        SizedBox(
          height: 1.h,
        ),
        const Text("Wifi"),
      ],
    );
  }
}
