import 'dart:ffi';

import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/drop_down_button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/create_realstate/create_realstate_bloc.dart';
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/update_realstate/update_realstate_bloc.dart';
import 'package:dalali_hub/app/pages/create_update_delete_realstate/widgets/build_chips_widget.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/app/widgets/multi_image_picker.dart';
import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/realstate.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateRealstatePage extends StatelessWidget {
  final String serviceName;
  final String action;
  final String category;
  final Realstate? realstate;

  const CreateRealstatePage(
      {super.key,
      required this.serviceName,
      required this.action,
      required this.category,
      this.realstate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<CreateRealstateBloc>(),
      child: CreateRealstate(
        serviceName: serviceName,
        action: action,
        category: category,
        firstTime: true,
        realstate: realstate,
      ),
    );
  }
}

// ignore: must_be_immutable
class CreateRealstate extends StatefulWidget {
  String serviceName;
  String action;
  String category;
  bool? firstTime;
  Realstate? realstate;
  CreateRealstate(
      {super.key,
      required this.serviceName,
      required this.action,
      required this.category,
      this.firstTime,
      this.realstate});

  @override
  State<CreateRealstate> createState() => _CreateRealstateState();
}

class _CreateRealstateState extends State<CreateRealstate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> currencies = ['USD', 'EUR', 'LB'];
  String? selectedCurrency;
  TextEditingController titleController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  String? realStateCategory;
  TextEditingController roomsController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController bathsController = TextEditingController();
  TextEditingController kitchensController = TextEditingController();
  TextEditingController sizeWidthController = TextEditingController();
  TextEditingController sizeHeightController = TextEditingController();

  String? selectedRegion;
  String? selectedDistrict;
  String? selectedWard;
  List<String> otherFeatures = [];
  TextEditingController otherFeaturesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isApproved = false;

  final List<String> sizeUnitItems = ["M", "Km", "Cm"];
  String? selectedSizeUnit;
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

  List<String> selectedImages = [];
  List<String> oldSelectedImages = [];
  List<String> selectedList = ["Shower"];
  void delete(String serviceName) {
    setState(() {
      selectedList.remove(serviceName);
    });
  }

  void add(String serviceName) {
    setState(() {
      selectedList.add(serviceName);
    });
  }

  void isFirstTime() {
    if (widget.firstTime == true && widget.action == "Update") {
      debugPrint('first time');
      widget.firstTime = false;
      titleController.text = widget.realstate!.title;
      minPriceController.text = widget.realstate!.minPrice.toString();
      maxPriceController.text = widget.realstate!.maxPrice.toString();
      roomsController.text = widget.realstate!.rooms.toString();
      bedsController.text = widget.realstate!.beds.toString();
      bathsController.text = widget.realstate!.baths.toString();
      kitchensController.text = widget.realstate!.kitchens.toString();
      sizeWidthController.text = widget.realstate!.size.toString();
      sizeHeightController.text = widget.realstate!.size.toString();
      selectedRegion = widget.realstate!.location.region;
      selectedDistrict = widget.realstate!.location.district;
      selectedWard = widget.realstate!.location.ward;
      selectedList = widget.realstate!.otherFeatures;
      descriptionController.text = widget.realstate!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    isFirstTime();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.7.h,
                ),
                AppInputField(
                  controller: titleController,
                  label: 'Title',
                  hint: "Sunny Place",
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 3.1.h,
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
                  height: 3.7.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppInputField(
                        controller: sizeWidthController,
                        label: 'Width size',
                        hint: "20",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Width size is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Expanded(
                      child: AppInputField(
                        keyboardType: TextInputType.number,
                        controller: sizeHeightController,
                        label: 'Height size',
                        hint: "30",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Height size is required';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                    Expanded(
                      child: AppDropDown(
                        paddingHorizontal: 2.w,
                        paddingVertical: 1.h,
                        labelStyle:
                            bodyTextStyle.copyWith(color: AppColors.white),
                        selectedValue: selectedSizeUnit,
                        dropDownValues: sizeUnitItems,
                        onChanged: (value) {
                          setState(() {
                            selectedSizeUnit = value!;
                          });
                        },
                        hint: "Size unit",
                        useItemBuilderForSelectedValue: false,
                        itemBuilder: (String item) {
                          return Container(
                            // width: 70.w,
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppInputField(
                        controller: roomsController,
                        label: 'Rooms',
                        hint: "5",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Number of rooms is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 6.1.w,
                    ),
                    Expanded(
                      child: AppInputField(
                        controller: bedsController,
                        label: 'Beds',
                        hint: "2",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Number of beds is required';
                          }

                          return null;
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppInputField(
                        controller: bathsController,
                        label: 'Baths',
                        hint: "3",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Number of bath is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 6.1.w,
                    ),
                    Expanded(
                      child: AppInputField(
                        controller: kitchensController,
                        label: 'Kitchens',
                        hint: "2",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Number of kitchen is required';
                          }

                          return null;
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
                    ),
                    SizedBox(
                      width: 3.7.h,
                    ),
                    Expanded(
                      child: AppDropDown(
                        labelStyle:
                            bodyTextStyle.copyWith(color: AppColors.white),
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
                    ),
                    SizedBox(
                      width: 3.7.h,
                    ),
                    MultiImagePicker(
                      activity: widget.action,
                      oldSelectedImages: oldSelectedImages,
                      selectedImages: selectedImages,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.w)),
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: AppColors.nauticalCreatures)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.9.w, vertical: 1.8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Pictures',
                              style: linkTextStylePrimary.copyWith(
                                  fontSize: 14.sp),
                            ),
                            SizedBox(
                              width: 4.5.w,
                            ),
                            Container(
                              width: 6.2.w,
                              height: 2.9.h,
                              decoration: BoxDecoration(
                                color: AppColors.nauticalCreatures,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1.w)),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.add,
                                color: AppColors.white,
                              )),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.7.h,
                ),
                AppInputField(
                  height: 26.6.w,
                  controller: otherFeaturesController,
                  label: 'Add other features',
                  hint: "Enter other features",
                  obscureText: false,
                  validator: (value) {
                    // if (value!.isEmpty) {
                    //   return 'Description is required';
                    // }
                    // if (value != newPasswordController.text) {
                    //   return 'Password does not match';
                    // }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    child: Container(
                      width: 6.2.w,
                      height: 2.9.h,
                      decoration: BoxDecoration(
                        color: AppColors.nauticalCreatures,
                        borderRadius: BorderRadius.all(Radius.circular(1.w)),
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.add,
                        color: AppColors.white,
                      )),
                    ),
                    onTap: () {
                      debugPrint(otherFeaturesController.text);
                      add(otherFeaturesController.text);
                      otherFeaturesController.clear();
                    },
                  ),
                ),
                Material(
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: selectedList
                        .map((e) => BuildChip(
                              label: e,
                              onDeleted: (serviceName) => delete(serviceName),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 2.7.h,
                ),
                AppInputField(
                  height: 26.6.w,
                  controller: descriptionController,
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
                BlocBuilder<CreateRealstateBloc, CreateRealstateState>(
                    builder: (context, state) {
                  return state.maybeMap(
                    loading: (_) => const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.nauticalCreatures,
                    )),
                    orElse: () => AppButtonPrimary(
                      color: AppColors.ultimateGray,
                      textStyle: bodyTextStyle.copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                      text: "Post",
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          debugPrint('form is not valid');
                          return;
                        }
                        if (widget.action == "Create") {
                          context.read<CreateRealstateBloc>().add(
                                CreateRealstateEvent.realstate(
                                  realstate: Realstate(
                                    title: titleController.text,
                                    category: widget.category,
                                    photos: selectedImages,
                                    minPrice:
                                        double.parse(minPriceController.text),
                                    maxPrice:
                                        double.parse(maxPriceController.text),
                                    rooms: double.parse(roomsController.text == "" ? "0" : roomsController.text),
                                    beds: double.parse(bedsController.text == "" ? "0" : bedsController.text),
                                    baths: double.parse(bathsController.text == "" ? "0" : bathsController.text),
                                    kitchens:
                                        double.parse(kitchensController.text == "" ? "0" : kitchensController.text),
                                    size:
                                        double.parse(sizeHeightController.text),
                                    sizeUnit: selectedSizeUnit ?? "M",
                                    otherFeatures: selectedList,
                                    description: descriptionController.text,
                                    isApproved: false,
                                    location: Location(
                                        region: selectedRegion ?? "Oromia",
                                        district: selectedDistrict ?? "sululta",
                                        ward: selectedWard ?? "mizan"),
                                    seats: int.parse(seatsController.text == "" ? "0" : seatsController.text),
                                  ),
                                ),
                              );
                        } else {
                          context.read<UpdateRealstateBloc>().add(
                                UpdateRealstateEvent.updateRealstate(
                                  realstate: Realstate(
                                      id: widget.realstate!.id,
                                      title: titleController.text,
                                      category: widget.category,
                                      photos: selectedImages,
                                      minPrice:
                                          double.parse(minPriceController.text),
                                      maxPrice:
                                          double.parse(maxPriceController.text),
                                      rooms: double.parse(roomsController.text == "" ? "0" : roomsController.text),
                                      beds: double.parse(bedsController.text == "" ? "0" : bedsController.text),
                                      baths: double.parse(bathsController.text == "" ? "0" : bathsController.text),
                                      kitchens:
                                          double.parse(kitchensController.text == "" ? "0" : kitchensController.text),
                                      size: double.parse(
                                          sizeHeightController.text),
                                      sizeUnit: selectedSizeUnit ?? "M",
                                      otherFeatures: selectedList,
                                      description: descriptionController.text,
                                      isApproved: widget.realstate!.isApproved,
                                      location: Location(
                                          region: selectedRegion ?? "Oromia",
                                          district:
                                              selectedDistrict ?? "sululta",
                                          ward: selectedWard ?? "mizan"),
                                      seats: int.parse(seatsController.text == "" ? "0" : seatsController.text)),
                                ),
                              );
                        }
                      },
                    ),
                  );
                }),
                BlocConsumer<CreateRealstateBloc, CreateRealstateState>(
                  listener: (context, state) {
                    state.maybeMap(
                      orElse: () {},
                      loading: (e) {
                        debugPrint('loading');
                      },
                      success: (e) {
                        debugPrint('success');
                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            showSuccessSnackBar(
                                '${widget.category} successfully created.', context));

                        // Navigator.pop(context);
                      },
                      error: (e) {
                        debugPrint('error');
                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            showErrorSnackBar(
                                'Error while adding house.', context));
                      },
                    );
                  },
                  builder: (context, state) {
                    return Container();
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
