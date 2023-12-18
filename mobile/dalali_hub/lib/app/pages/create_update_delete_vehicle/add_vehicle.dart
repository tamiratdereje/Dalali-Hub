import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/drop_down_button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/create_vehicle/create_vehicle_bloc.dart';
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/update_vehicle/update_vehicle_bloc.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/app/widgets/multi_image_picker.dart';
import 'package:dalali_hub/domain/entity/location.dart';
import 'package:dalali_hub/domain/entity/vehicle.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateVehiclePage extends StatelessWidget {
  final String serviceName;
  final String action;
  final String category;
  final Vehicle? vehicle;

  const CreateVehiclePage(
      {super.key,
      required this.serviceName,
      required this.action,
      required this.category,
      this.vehicle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<CreateVehicleBloc>(),
      child: CreateVehicle(
        serviceName: serviceName,
        action: action,
        category: category,
        firstTime: true,
        vehicle: vehicle,
      ),
    );
  }
}

// ignore: must_be_immutable
class CreateVehicle extends StatefulWidget {
  String serviceName;
  String action;
  String category;
  bool? firstTime;
  Vehicle? vehicle;
  CreateVehicle(
      {super.key,
      required this.serviceName,
      required this.action,
      required this.category,
      this.firstTime,
      this.vehicle});

  @override
  State<CreateVehicle> createState() => _CreateVehicleState();
}

class _CreateVehicleState extends State<CreateVehicle> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> currencies = ['USD', 'EUR', 'LB'];
  String? selectedCurrency;
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController vinController = TextEditingController();
  TextEditingController fuelTypeController = TextEditingController();
  TextEditingController engineSizeController = TextEditingController();
  TextEditingController transmissionTypeController = TextEditingController();
  TextEditingController mileageController = TextEditingController();
  TextEditingController conditionController = TextEditingController();

  String? selectedRegion;
  String? selectedDistrict;
  String? selectedWard;
  bool isApproved = false;

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
      makeController.text = widget.vehicle!.make;
      modelController.text = widget.vehicle!.model;
      priceController.text = widget.vehicle!.price.toString();
      yearController.text = widget.vehicle!.year.toString();
      colorController.text = widget.vehicle!.color;
      vinController.text = widget.vehicle!.vin;
      fuelTypeController.text = widget.vehicle!.fuelType;
      engineSizeController.text = widget.vehicle!.engineSize.toString();
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
                  controller: makeController,
                  label: 'Make',
                  hint: "Toyota",
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Make is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 3.1.h,
                ),
                AppInputField(
                  controller: modelController,
                  label: 'Model',
                  hint: "Tucson 45",
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Model is required';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppInputField(
                        controller: priceController,
                        label: 'Price',
                        hint: "550000",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Price is required';
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
                        controller: yearController,
                        label: 'Year',
                        hint: "2017",
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Year is required';
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
                        controller: colorController,
                        label: 'Color',
                        hint: "Black",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Color is required';
                          }
                          // if (value != newPasswordController.text) {
                          //   return 'Password does not match';
                          // }
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
                        controller: fuelTypeController,
                        label: 'Fuel Type',
                        hint: "Gasoline",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Fuel Type is required';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 3.1.w,
                    ),
                    Expanded(
                      child: AppInputField(
                        controller: engineSizeController,
                        label: 'Engine Size',
                        hint: "4",
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Engine size is required';
                          }
                          // if (value != newPasswordController.text) {
                          //   return 'Password does not match';
                          // }
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
                        controller: vinController,
                        label: 'Vin',
                        hint: "fhg52g1rrgD",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Vin is required';
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
                        controller: transmissionTypeController,
                        label: 'Transmission Type',
                        hint: "Fortuna",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Transmission type is required';
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
                AppInputField(
                  controller: mileageController,
                  label: 'Mileage',
                  hint: "25000",
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mileage is required';
                    }
                    // if (value != newPasswordController.text) {
                    //   return 'Password does not match';
                    // }
                    return null;
                  },
                ),
                SizedBox(
                  height: 3.7.h,
                ),
                AppInputField(
                  controller: conditionController,
                  height: 26.6.w,
                  label: 'Condition',
                  hint: "It is brand new toyota with zero mileage.",
                  obscureText: false,
                  minLine: 3,
                  maxLine: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Color is required';
                    }
                    // if (value != newPasswordController.text) {
                    //   return 'Password does not match';
                    // }
                    return null;
                  },
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
                BlocBuilder<CreateVehicleBloc, CreateVehicleState>(
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
                          context.read<CreateVehicleBloc>().add(
                                CreateVehicleEvent.vehicle(
                                  vehicle: Vehicle(
                                    numberOfViews: 0,
                                    make: makeController.text,
                                    model: modelController.text,
                                    photos: selectedImages,
                                    year: int.parse(yearController.text),
                                    color: colorController.text,
                                    vin: vinController.text,
                                    fuelType: fuelTypeController.text,
                                    engineSize:
                                        int.parse(engineSizeController.text),
                                    transmissionType:
                                        transmissionTypeController.text,
                                    mileage:
                                        double.parse(mileageController.text),
                                    price: double.parse(priceController.text),
                                    location: Location(
                                      region: selectedRegion!,
                                      district: selectedDistrict!,
                                      ward: selectedWard!,
                                    ),
                                    condition: conditionController.text,
                                    category: "Vehicle",
                                    isApproved: false
                                  ),
                                ),
                              );
                        } else {
                          context.read<UpdateVehicleBloc>().add(
                                UpdateVehicleEvent.updateVehicle(
                                  vehicle: Vehicle(
                                    numberOfViews: widget.vehicle!.numberOfViews ,
                                    make: makeController.text,
                                    model: modelController.text,
                                    photos: selectedImages,
                                    year: int.parse(yearController.text),
                                    color: colorController.text,
                                    vin: vinController.text,
                                    fuelType: fuelTypeController.text,
                                    engineSize:
                                        int.parse(engineSizeController.text),
                                    transmissionType:
                                        transmissionTypeController.text,
                                    mileage:
                                        double.parse(mileageController.text),
                                    price: double.parse(priceController.text),
                                    location: Location(
                                      region: selectedRegion!,
                                      district: selectedDistrict!,
                                      ward: selectedWard!,
                                    ),
                                    condition: conditionController.text,
                                    category: "Vehicle",
                                    isApproved: false
                                  ),
                                ),
                              );
                        }
                      },
                    ),
                  );
                }),
                BlocConsumer<CreateVehicleBloc, CreateVehicleState>(
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
                                'Vehicle successfully created.', context));

                        // Navigator.pop(context);
                      },
                      error: (e) {
                        debugPrint('error');
                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            showErrorSnackBar(
                                'Error while adding vehicle.', context));
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
