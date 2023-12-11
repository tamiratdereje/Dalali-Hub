import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/drop_down_button.dart';
import 'package:dalali_hub/app/core/widgets/hall_card.dart';
import 'package:dalali_hub/app/core/widgets/house_card.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

class HouseFilter extends StatefulWidget {
  final String serviceName;
  const HouseFilter({super.key, required this.serviceName});

  @override
  State<HouseFilter> createState() => _HouseFilterState();
}

class _HouseFilterState extends State<HouseFilter> {
  String? selectedRegion;
  String? selectedDistrict;
  String? selectedWard;

  final List<String> regions = [
    "Dodoma",
    "Singida",
    "Tabora",
    "Dar es",
    "Lindi",
    "Morogoro",
    "Mtwara",
    "Pwani"
  ];
  final List<String> districts = [
    "Ilala",
    "Kinondoni",
    "Temeke",
    "Mwanza",
    "Shinyanga",
    "Kagera"
  ];
  final List<String> wards = [
    "Sululta",
    "Duber",
    "Bahirdar",
    "Gonder",
    "Ambo",
    "Waldiya"
  ];
  int sliderValue = 1;
  String? selectedValue;

  double _lowerValue = 2;
  double _upperValue = 14;
  TextEditingController maxPriceController = TextEditingController();
  List<String> currencies = ['USD', 'EUR', 'LB'];
  String? selectedCurrency;
  TextEditingController minPriceController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.7.h,
              ),
              Text("Number of rooms", style: inputFieldLabelStyle),
              SizedBox(
                height: 1.4.h,
              ),
              RangeSliderFlutter(
                // key: Key('3343'),
                values: [_lowerValue, _upperValue],

                rangeSlider: true,
                tooltip: RangeSliderFlutterTooltip(
                  alwaysShowTooltip: true,
                  rightSuffix: Text(
                    " rooms",
                    style: bodyTextStyle.copyWith(color: AppColors.white),
                  ),
                  leftSuffix: Text(" rooms",
                      style: bodyTextStyle.copyWith(color: AppColors.white)),
                ),
                textPositionBottom: -100,
                max: 20,
                // textPositionTop: 0,

                handlerHeight: 27,
                textBackgroundColor: AppColors.nauticalCreatures,

                trackBar: RangeSliderFlutterTrackBar(
                  activeTrackBarHeight: 10,
                  inactiveTrackBarHeight: 10,
                  activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.nauticalCreatures,
                  ),
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.doctor,
                  ),
                ),
                // handler: RangeSliderFlutterHandler(
                //   decoration: BoxDecoration(
                //     color: Colors.yellow,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
                min: 0,
                fontSize: 15,
                // textColor: ,

                onDragging: (handlerIndex, lowerValue, upperValue) {
                  _lowerValue = lowerValue;
                  _upperValue = upperValue;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 2.4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AppInputField(
                      controller: minPriceController,
                      label: 'Min Price',
                      hint: "550",
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        // if (value != newPasswordController.text) {
                        //   return 'Password does not match';
                        // }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 3.1.w,
                  ),
                  Expanded(
                    child: AppInputField(
                      controller: maxPriceController,
                      label: 'Max Price',
                      hint: "750",
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        // if (value != newPasswordController.text) {
                        //   return 'Password does not match';
                        // }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 3.1.w,
                  ),
                  Expanded(
                    child: AppDropDown(
                      labelStyle:
                          bodyTextStyle.copyWith(color: AppColors.white),
                      selectedValue: selectedCurrency,
                      paddingHorizontal: 2.w,
                      paddingVertical: 1.h,
                      dropDownValues: currencies,
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value!;
                        });
                      },
                      hint: "Currency",
                      useItemBuilderForSelectedValue: false,
                      itemBuilder: (String item) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.1.w),
                          child: Text(
                            item,
                            style: categoryContainerStyle.copyWith(
                                color: AppColors.black.withOpacity(0.5)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.4.h,
              ),
              AppDropDown(
                labelStyle: bodyTextStyle.copyWith(color: AppColors.white),
                selectedValue: selectedRegion,
                dropDownValues: regions,
                onChanged: (value) {
                  setState(() {
                    selectedRegion = value!;
                  });
                },
                hint: "Region",
                useItemBuilderForSelectedValue: false,
                itemBuilder: (String item) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.1.w),
                    child: Text(
                      item,
                      style: categoryContainerStyle.copyWith(
                          color: AppColors.black.withOpacity(0.5)),
                      overflow: TextOverflow.clip,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 1.4.h,
              ),
              AppDropDown(
                labelStyle: bodyTextStyle.copyWith(color: AppColors.white),
                selectedValue: selectedDistrict,
                dropDownValues: districts,
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value!;
                  });
                },
                hint: "District",
                useItemBuilderForSelectedValue: false,
                itemBuilder: (String item) {
                  return Container(
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
                selectedValue: selectedWard,
                dropDownValues: wards,
                onChanged: (value) {
                  setState(() {
                    selectedWard = value!;
                  });
                },
                hint: "Ward",
                useItemBuilderForSelectedValue: false,
                itemBuilder: (String item) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.1.w),
                    child: Text(
                      item,
                      style: categoryContainerStyle.copyWith(
                          color: AppColors.black.withOpacity(0.5)),
                      overflow: TextOverflow.clip,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              AppButtonPrimary(
                onPressed: () {},
                text: "Search",
                color: AppColors.ultimateGray,
                textStyle:
                    onPrimaryButtonTextStyle.copyWith(color: AppColors.white),
              ),
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
                    return HouseCard(
                      onTap: () {},
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
