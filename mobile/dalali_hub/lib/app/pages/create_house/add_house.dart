import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/drop_down_button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/broker_home/widgets/broker_service_container.dart';
import 'package:dalali_hub/app/pages/broker_home/widgets/broker_statics.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class CreateHouse extends StatefulWidget {
  String serviceName;
  CreateHouse({super.key, required this.serviceName});

  @override
  State<CreateHouse> createState() => _CreateHouseState();
}

class _CreateHouseState extends State<CreateHouse> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
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
                  hint: "Type of house",
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
                  height: 3.7.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppInputField(
                        // controller: repeatPasswordController,
                        label: 'Price',
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
                      width: 6.1.w,
                    ),
                    Expanded(
                      child: AppDropDown(
                        labelStyle:
                            bodyTextStyle.copyWith(color: AppColors.white),
                        selectedValue: selectedNumberOfRooms,
                        dropDownValues: numberOfRooms,
                        onChanged: (value) {
                          setState(() {
                            selectedNumberOfRooms = value!;
                          });
                        },
                        hint: "Currency",
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.7.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppDropDown(
                        labelStyle:
                            bodyTextStyle.copyWith(color: AppColors.white),
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
                    ),
                    SizedBox(
                      width: 3.7.h,
                    ),
                    Expanded(
                      child: AppDropDown(
                        labelStyle:
                            bodyTextStyle.copyWith(color: AppColors.white),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.7.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppDropDown(
                        labelStyle:
                            bodyTextStyle.copyWith(color: AppColors.white),
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
                    ),
                    SizedBox(
                      width: 3.7.h,
                    ),
                    Expanded(
                      child: AppDropDown(
                        labelStyle:
                            bodyTextStyle.copyWith(color: AppColors.white),
                        selectedValue: selectedNumberOfRooms,
                        dropDownValues: numberOfRooms,
                        onChanged: (value) {
                          setState(() {
                            selectedNumberOfRooms = value!;
                          });
                        },
                        hint: "Add pictures",
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.7.h,
                ),
                const Text("Add other features"),
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
                  height: 2.7.h,
                ),
                AppInputField(
                  height: 26.6.w,
                  // controller: repeatPasswordController,
                  label: 'Other Description',
                  hint: "Enter description",
                  minLine: 3,
                  maxLine: 5,
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Description is required';
                    }
                    // if (value != newPasswordController.text) {
                    //   return 'Password does not match';
                    // }
                    return null;
                  },
                ),
                SizedBox(
                  height: 2.7.h,
                ),
                AppButtonPrimary(
                  color: AppColors.ultimateGray,
                  textStyle: bodyTextStyle.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                  text: "Post",
                  onPressed: () {
                    // if (!_formKey.currentState!.validate()) {
                    //   debugPrint('form is not valid');
                    //   return;
                    // }
                    // if (repeatPasswordController.text !=
                    //     newPasswordController.text) {
                    //   showAppDialog(
                    //       context: context,
                    //       errorAlert: true,
                    //       title: 'Opps, Wrong password',
                    //       description: 'You have entered a wrong password',
                    //       buttonLabel: 'Try again');
                    // } else {
                    //   showAppDialog(
                    //       context: context,
                    //       title: 'Congratulations!',
                    //       description: 'Your account is ready',
                    //       buttonLabel: 'Log in');
                    // }
                  },
                ),
              ],
            ),
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
