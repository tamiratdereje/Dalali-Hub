import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/drop_down_button.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/customer_service_container.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/house_card.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HouseFilter extends StatefulWidget {
  final String serviceName;
  const HouseFilter({super.key, required this.serviceName});

  @override
  State<HouseFilter> createState() => _HouseFilterState();
}

class _HouseFilterState extends State<HouseFilter> {
  List<String> numberOfRooms = ['1', '2', '3', '4'];
  String? selectedNumberOfRooms;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomerAppBar(title: widget.serviceName),
      body: Padding(
        padding: EdgeInsets.only(
          left: 6.6.w,
          right: 6.6.w,
          bottom: 5.6.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.7.h,
              ),
              AppDropDown(
                labelStyle: bodyTextStyle.copyWith(color: AppColors.white),
                selectedValue: selectedNumberOfRooms,
                dropDownValues: numberOfRooms,
                onChanged: (value) {
                  setState(() {
                    selectedNumberOfRooms = value!;
                  });
                },
                hint: "Number of rooms",
                useItemBuilderForSelectedValue: false,
                itemBuilder: (String item) {
                  return Container(
                    width: 70.w,
                    padding: EdgeInsets.symmetric(horizontal: 3.1.w),
                    child: Text(
                      item,
                      style: categoryContainerStyle.copyWith(
                          color: AppColors.black.withOpacity(0.5)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 1.4.h,
              ),
              AppDropDown(
                labelStyle: bodyTextStyle.copyWith(color: AppColors.white),
                selectedValue: selectedNumberOfRooms,
                dropDownValues: numberOfRooms,
                onChanged: (value) {
                  setState(() {
                    selectedNumberOfRooms = value!;
                  });
                },
                hint: "Region",
                useItemBuilderForSelectedValue: false,
                itemBuilder: (String item) {
                  return Container(
                    width: 70.w,
                    padding: EdgeInsets.symmetric(horizontal: 3.1.w),
                    child: Text(
                      item,
                      style: categoryContainerStyle.copyWith(
                          color: AppColors.black.withOpacity(0.5)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 1.4.h,
              ),
              AppDropDown(
                labelStyle: bodyTextStyle.copyWith(color: AppColors.white),
                selectedValue: selectedNumberOfRooms,
                dropDownValues: numberOfRooms,
                onChanged: (value) {
                  setState(() {
                    selectedNumberOfRooms = value!;
                  });
                },
                hint: "District",
                useItemBuilderForSelectedValue: false,
                itemBuilder: (String item) {
                  return Container(
                    width: 70.w,
                    padding: EdgeInsets.symmetric(horizontal: 3.1.w),
                    child: Text(
                      item,
                      style: categoryContainerStyle.copyWith(
                          color: AppColors.black.withOpacity(0.5)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 1.4.h,
              ),
              AppDropDown(
                labelStyle: bodyTextStyle.copyWith(color: AppColors.white),
                selectedValue: selectedNumberOfRooms,
                dropDownValues: numberOfRooms,
                onChanged: (value) {
                  setState(() {
                    selectedNumberOfRooms = value!;
                  });
                },
                hint: "Ward",
                useItemBuilderForSelectedValue: false,
                itemBuilder: (String item) {
                  return Container(
                    width: 70.w,
                    padding: EdgeInsets.symmetric(horizontal: 3.1.w),
                    child: Text(
                      item,
                      style: categoryContainerStyle.copyWith(
                          color: AppColors.black.withOpacity(0.5)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 1.4.h,
              ),
              AppDropDown(
                labelStyle: bodyTextStyle.copyWith(color: AppColors.white),
                selectedValue: selectedNumberOfRooms,
                dropDownValues: numberOfRooms,
                onChanged: (value) {
                  setState(() {
                    selectedNumberOfRooms = value!;
                  });
                },
                hint: "Price range",
                useItemBuilderForSelectedValue: false,
                itemBuilder: (String item) {
                  return Container(
                    width: 70.w,
                    padding: EdgeInsets.symmetric(horizontal: 3.1.w),
                    child: Text(
                      item,
                      style: categoryContainerStyle.copyWith(
                          color: AppColors.black.withOpacity(0.5)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              AppButtonPrimary(onPressed: () {}, text: "Search", color: AppColors.ultimateGray, textStyle: onPrimaryButtonTextStyle.copyWith(color: AppColors.white),),
              SizedBox(
                height: 10.3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Those within a distance of 10 kilometers",
                    style: categoryContainerStyle.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    "Show all",
                    style: buttonContainerBoldStyle,
                  )
                ],
              ),
              SizedBox(
                height: 3.4.h,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const HouseCard();
                  }),
              const HouseCard()
            ],
          ),
        ),
      ),
    );
  }
}
