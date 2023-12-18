import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/drop_down_button.dart';
import 'package:dalali_hub/app/core/widgets/hall_card.dart';
import 'package:dalali_hub/app/core/widgets/house_card.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/core/widgets/land_card.dart';
import 'package:dalali_hub/app/core/widgets/office_card.dart';
import 'package:dalali_hub/app/core/widgets/vehicle_card.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/pages/property_filter/bloc/filter_realstate/filter_realstate_bloc.dart';
import 'package:dalali_hub/app/pages/property_filter/bloc/filter_vehicle/filter_vehicle_bloc.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/domain/entity/filter_parameter.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

class PropertyFilterPage extends StatelessWidget {
  final String serviceName;

  const PropertyFilterPage({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    if (serviceName == "Vehicle") {
      return BlocProvider(
        create: (context) => getIt.get<FilterVehicleBloc>()
          ..add(FilterVehicleEvent.vehicle(
              filterParameter: FilterParameter(
            category: serviceName,
          ))),
        child: PropertyFilter(serviceName: serviceName),
      );
    } else {
      return BlocProvider(
        create: (context) => getIt.get<FilterRealstateBloc>()
          ..add(FilterRealstateEvent.realstate(
              filterParameter: FilterParameter(
            category: serviceName,
          ))),
        child: PropertyFilter(serviceName: serviceName),
      );
    }
  }
}

class PropertyFilter extends StatefulWidget {
  final String serviceName;
  const PropertyFilter({super.key, required this.serviceName});

  @override
  State<PropertyFilter> createState() => _PropertyFilterState();
}

class _PropertyFilterState extends State<PropertyFilter> {
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

  // number of rooms
  double _lowerRooms = 0;
  double _higherRooms = 50;

  // number of seats
  double _lowerSeats = 2;
  double _higherSeats = 14;

  TextEditingController widthSizeController = TextEditingController();
  TextEditingController heightSizeController = TextEditingController();

  TextEditingController maxPriceController = TextEditingController();
  List<String> currencies = ['USD', 'EUR', 'LB'];
  String? selectedCurrency;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController minYearController = TextEditingController();
  TextEditingController maxYearController = TextEditingController();
  TextEditingController minSeatController = TextEditingController();
  TextEditingController maxSeatController = TextEditingController();

  bool isFiltered = false;

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
              if (widget.serviceName == "House for rent" ||
                  widget.serviceName == "House for sell" ||
                  widget.serviceName == "Short stay apartment" ||
                  widget.serviceName == "Office") ...[
                Text("Number of rooms", style: inputFieldLabelStyle),
                SizedBox(
                  height: 1.4.h,
                ),
                RangeSliderFlutter(
                  // key: Key('3343'),
                  values: [_lowerRooms, _higherRooms],

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
                  max: 50,
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
                    _lowerRooms = lowerValue;
                    _higherRooms = upperValue;
                    setState(() {});
                  },
                ),
              ],
              if (widget.serviceName == "Land") ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppInputField(
                        controller: minPriceController,
                        label: 'Min Size',
                        hint: "25,000",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Min price is required';
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
                        label: 'Max SIze',
                        hint: "850,000",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Max price is required';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
              if (widget.serviceName == "Hall") ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppInputField(
                        controller: minSeatController,
                        label: 'Min seats',
                        hint: "30",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Min seat is required';
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
                        controller: maxSeatController,
                        label: 'Max seats',
                        hint: "160",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Max seat is required';
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
              ],
              if (widget.serviceName == "Vehicle") ...[
                AppInputField(
                  controller: makeController,
                  label: 'Make',
                  hint: "Toyota",
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Make is required';
                    }
                    // if (value != newPasswordController.text) {
                    //   return 'Password does not match';
                    // }
                    return null;
                  },
                ),
                SizedBox(
                  height: 1.4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppInputField(
                        controller: minYearController,
                        label: 'Min years',
                        hint: "30",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Min years is required';
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
                        controller: maxYearController,
                        label: 'Max years',
                        hint: "160",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Max years is required';
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
              ],
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
                onPressed: () {
                  isFiltered = true;

                  if (widget.serviceName != "Vehicle") {
                    BlocProvider.of<FilterRealstateBloc>(context)
                        .add(FilterRealstateEvent.realstate(
                      filterParameter: FilterParameter(
                        category: widget.serviceName,
                        lowerPrice: (minPriceController.text.trim() != "" ||
                                maxPriceController.text.trim() != "")
                            ? double.parse(minPriceController.text.trim())
                            : null,
                        upperPrice: (minPriceController.text.trim() != "" ||
                                maxPriceController.text.trim() != "")
                            ? double.parse(maxPriceController.text.trim())
                            : null,
                        minYears: (minYearController.text.trim() != "" ||
                                maxYearController.text.trim() != "")
                            ? int.parse(minYearController.text.trim())
                            : null,
                        maxYears: (minYearController.text.trim() != "" ||
                                maxYearController.text.trim() != "")
                            ? int.parse(maxYearController.text.trim())
                            : null,
                        make: makeController.text.trim() != ""
                            ? makeController.text.trim()
                            : null,
                        lowerSeats: (minSeatController.text.trim() != "" ||
                                maxSeatController.text.trim() != "")
                            ? int.parse(minSeatController.text.trim())
                            : null,
                        upperSeats: (minSeatController.text.trim() != "" ||
                                maxSeatController.text.trim() != "")
                            ? int.parse(maxSeatController.text.trim())
                            : null,
                        lowerRooms: _lowerRooms.toInt(),
                        upperRooms: _higherRooms.toInt(),
                        region: selectedRegion,
                        district: selectedDistrict,
                        ward: selectedWard,
                        widthSize: (widthSizeController.text.trim() != "" ||
                                heightSizeController.text.trim() != "")
                            ? double.parse(widthSizeController.text.trim())
                            : null,
                        heightSize: (widthSizeController.text.trim() != "" ||
                                heightSizeController.text.trim() != "")
                            ? double.parse(heightSizeController.text.trim())
                            : null,
                        currency: selectedCurrency,
                      ),
                    ));
                  } else {
                    BlocProvider.of<FilterVehicleBloc>(context)
                        .add(FilterVehicleEvent.vehicle(
                            filterParameter: FilterParameter(
                      category: widget.serviceName,
                      lowerPrice: (minPriceController.text.trim() != "" ||
                              maxPriceController.text.trim() != "")
                          ? double.parse(minPriceController.text.trim())
                          : null,
                      upperPrice: (minPriceController.text.trim() != "" ||
                              maxPriceController.text.trim() != "")
                          ? double.parse(maxPriceController.text.trim())
                          : null,
                      minYears: (minYearController.text.trim() != "" ||
                              maxYearController.text.trim() != "")
                          ? int.parse(minYearController.text.trim())
                          : null,
                      maxYears: (minYearController.text.trim() != "" ||
                              maxYearController.text.trim() != "")
                          ? int.parse(maxYearController.text.trim())
                          : null,
                      make: makeController.text.trim() != ""
                          ? makeController.text.trim()
                          : null,
                      lowerSeats: (minSeatController.text.trim() != "" ||
                              maxSeatController.text.trim() != "")
                          ? int.parse(minSeatController.text.trim())
                          : null,
                      upperSeats: (minSeatController.text.trim() != "" ||
                              maxSeatController.text.trim() != "")
                          ? int.parse(maxSeatController.text.trim())
                          : null,
                      lowerRooms: null,
                      upperRooms: null,
                      region: selectedRegion,
                      district: selectedDistrict,
                      ward: selectedWard,
                      widthSize: (widthSizeController.text.trim() != "" ||
                              heightSizeController.text.trim() != "")
                          ? double.parse(widthSizeController.text.trim())
                          : null,
                      heightSize: (widthSizeController.text.trim() != "" ||
                              heightSizeController.text.trim() != "")
                          ? double.parse(heightSizeController.text.trim())
                          : null,
                      currency: selectedCurrency,
                    )));
                  }
                },
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

              if (widget.serviceName != "Vehicle")
                BlocConsumer<FilterRealstateBloc, FilterRealstateState>(
                  listener: (context, state) {
                    state.maybeMap(orElse: (){},
                    success: (value) {
                      if (isFiltered) {
                          context.push(AppRoutes.filterResult, extra: {
                            "propertyList": value.realstates,
                          });
                        }
                      
                    },);
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      orElse: () => Container(),
                      initial: (_) => Container(),
                      loading: (_) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      success: (data) {
                        

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.realstates.length,
                            itemBuilder: (context, index) {
                              if (widget.serviceName == "Hall") {
                                debugPrint("Hall seats");
                                debugPrint(
                                    data.realstates[index].seats.toString());
                                return HallCard(
                                  title: data.realstates[index].title ?? "",
                                  location:
                                      data.realstates[index].location.ward,
                                  price: data.realstates[index].price
                                      .toString(),
                                  sqft: data.realstates[index].sizeWidth.toString(),
                                  seats:
                                      data.realstates[index].seats.toString(),
                                  onTap: () {
                                    context.push(AppRoutes.propertyDetail,
                                        extra: {
                                          "feed": data.realstates[index],
                                          "category": widget.serviceName
                                        });
                                  },
                                  photo: data
                                      .realstates[index].photos[0].secoureUrl,
                                );
                              } else if (widget.serviceName == "Office") {
                                return OfficeCard(
                                    title: data.realstates[index].title ?? "",
                                    location:
                                        data.realstates[index].location.ward,
                                    price: data.realstates[index].price
                                        .toString(),
                                    sqft:
                                        data.realstates[index].sizeWidth.toString(),
                                    rooms:
                                        data.realstates[index].rooms.toString(),
                                    onTap: () {
                                      context.push(AppRoutes.propertyDetail,
                                          extra: {
                                            "feed": data.realstates[index],
                                            "category": widget.serviceName
                                          });
                                    },
                                    photo: data.realstates[index].photos[0]
                                        .secoureUrl);
                              } else if (widget.serviceName == "Land") {
                                return LandCard(
                                    title: data.realstates[index].title ?? "",
                                    location:
                                        data.realstates[index].location.ward,
                                    price: data.realstates[index].price
                                        .toString(),
                                    sqft:
                                        data.realstates[index].sizeWidth.toString(),
                                    onTap: () {
                                      context.push(AppRoutes.propertyDetail,
                                          extra: {
                                            "feed": data.realstates[index],
                                            "category": widget.serviceName
                                          });
                                    },
                                    photo: data.realstates[index].photos[0]
                                        .secoureUrl);
                              } else if (widget.serviceName ==
                                      "House for rent" ||
                                  widget.serviceName == "House for sell" ||
                                  widget.serviceName ==
                                      "Short stay apartment") {
                                return HouseCard(
                                  title: data.realstates[index].title ?? "",
                                  location:
                                      data.realstates[index].location.ward,
                                  beds: data.realstates[index].beds.toString(),
                                  baths:
                                      data.realstates[index].baths.toString(),
                                  price: data.realstates[index].price
                                      .toString(),
                                  sqft: data.realstates[index].sizeWidth.toString(),
                                  onTap: () {
                                    context.push(AppRoutes.propertyDetail,
                                        extra: {
                                          "feed": data.realstates[index],
                                          "category": widget.serviceName
                                        });
                                  },
                                  photo: data
                                      .realstates[index].photos[0].secoureUrl,
                                );
                              }
                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text("Category doesn't exist"),
                              );
                            });
                      },
                      error: (error) => Center(
                        child: Text(error.toString()),
                      ),
                    );
                  },
                ),
              if (widget.serviceName == "Vehicle")
                BlocConsumer<FilterVehicleBloc, FilterVehicleState>(
                   listener: (context, state) {
                    state.maybeMap(orElse: (){},
                    success: (value) {
                      if (isFiltered) {
                          context.push(AppRoutes.filterResult, extra: {
                            "propertyList": value.vehicles,
                          });
                        }
                      
                    },);
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      orElse: () => Container(),
                      initial: (_) => Container(),
                      loading: (_) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      success: (data) {
                        
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.vehicles.length,
                            itemBuilder: (context, index) {
                              return VehicleCard(
                                  price: data.vehicles[index].price.toString(),
                                  make: data.vehicles[index].make,
                                  location: data.vehicles[index].location.ward,
                                  engineSize: data.vehicles[index].engineSize
                                      .toString(),
                                  color: data.vehicles[index].color,
                                  year: data.vehicles[index].year.toString(),
                                  onTap: () {
                                    context.push(AppRoutes.propertyDetail,
                                        extra: {
                                          "feed": data.vehicles[index],
                                          "category": widget.serviceName
                                        });
                                  },
                                  photo: data
                                      .vehicles[index].photos[0].secoureUrl);
                            });
                      },
                      error: (error) => Center(
                        child: Text(error.toString()),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
