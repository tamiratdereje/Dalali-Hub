import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/pages/customer_home/bloc/feeds/feeds_bloc.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/pages/favorite/bloc/add_to_my_favorite/add_to_my_favorite_bloc.dart';
import 'package:dalali_hub/app/pages/favorite/bloc/get_my_favorites/get_my_favorites_bloc.dart';
import 'package:dalali_hub/app/pages/favorite/bloc/remove_from_my_favorite/remove_from_my_favorite_bloc.dart';
import 'package:dalali_hub/app/pages/property_detail_for_customer/bloc/get_property/get_property_bloc.dart';
import 'package:dalali_hub/app/pages/property_detail_for_customer/widgets/other_features_chips.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PropertyDetailPage extends StatelessWidget {
  final String feedId;
  const PropertyDetailPage({super.key, required this.feedId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<RemoveFromMyFavoriteBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<AddToMyFavoriteBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<GetPropertyBloc>()
            ..add(GetPropertyEvent.getProperty(feedId)),
        )
      ],
      child: const PropertyDetail(),
    );
  }
}

class PropertyDetail extends StatefulWidget {
  const PropertyDetail({
    super.key,
  });

  @override
  State<PropertyDetail> createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  List<String> selectedList = ["Shower", "Wifi", "Parking", "Garden"];
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomerAppBar(
        title: "Property Detail",
        color: AppColors.doctor.withOpacity(0.5),
      ),
      extendBodyBehindAppBar: true,
      body: BlocConsumer<GetPropertyBloc, GetPropertyState>(
        listener: (context, state) async {
          state.maybeMap(
            orElse: () => Container(),
            success: (value) {
              setState(() {
                isFavorite = value.feed.isFavorite ?? false;
              });
              debugPrint("what the success is working ");
            },
          );
        },
        builder: ((context, state) {
          return state.maybeMap(
            orElse: () {
              return Container();
            },
            initial: (value) {
              return Container();
            },
            loading: (value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (value) {
              return Center(
                child: Text(value.message),
              );
            },
            success: (value) {
              return Padding(
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
                          image: DecorationImage(
                            image:
                                NetworkImage(value.feed.photos[0].secoureUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.7.h,
                      ),
                      if (value.feed.category != "Vehicle")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(value.feed.title ?? "",
                                style: appBarTitleStyle),
                            SizedBox(
                              width: 2.7.w,
                            ),
                            IconButton(
                              onPressed: () {
                                if (!isFavorite) {
                                  setState(() {
                                    isFavorite = true;
                                  });
                                  showSuccessSnackBar(
                                      "Property successfully added to favorite.",
                                      context);

                                  context.read<AddToMyFavoriteBloc>().add(
                                        AddToMyFavoriteEvent.addToMyFavorite(
                                            value.feed.id),
                                      );
                                } else {
                                  setState(() {
                                    isFavorite = false;
                                  });
                                  showSuccessSnackBar(
                                      "Property successfully removed from favorite.",
                                      context);

                                  context.read<RemoveFromMyFavoriteBloc>().add(
                                        RemoveFromMyFavoriteEvent
                                            .removeFromMyFavorite(
                                                value.feed.id),
                                      );
                                }
                              },
                              icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColors.nauticalCreatures),
                            ),
                          ],
                        ),
                      BlocConsumer<AddToMyFavoriteBloc, AddToMyFavoriteState>(
                        listener: (context, state) async {
                          state.maybeMap(
                            orElse: () => Container(),
                            success: (data) {
                              setState(() {
                                // isFavorite = true;
                                // BlocProvider.of<GetPropertyBloc>(context).add(
                                //     GetPropertyEvent.updateFavorite(
                                //         value.feed.id));

                                // BlocProvider.of<GetMyFavoritesBloc>(context)
                                //     .add(GetMyFavoritesEvent.updateFavorite(
                                //         value.feed));

                                // BlocProvider.of<FeedsBloc>(context).add(
                                //     FeedsEvent.updateFavorite(value.feed.id));
                              });
                              debugPrint("what the success is working ");
                            },
                            error: (value) {
                              setState(() {
                                isFavorite = false;
                              });
                              showErrorSnackBar(
                                  "Unable to add property to favorite.",
                                  context);
                            },
                          );
                        },
                        builder: ((context, state) {
                          return Container();
                        }),
                      ),
                      BlocConsumer<RemoveFromMyFavoriteBloc,
                          RemoveFromMyFavoriteState>(
                        listener: (context, state) async {
                          state.maybeMap(
                            orElse: () => Container(),
                            success: (data) {
                              setState(() {
                                // isFavorite = false;
                                // BlocProvider.of<GetPropertyBloc>(context).add(
                                //     GetPropertyEvent.updateFavorite(
                                //         value.feed.id));

                                // BlocProvider.of<GetMyFavoritesBloc>(context)
                                //     .add(GetMyFavoritesEvent.updateFavorite(
                                //         value.feed));

                                // BlocProvider.of<FeedsBloc>(context).add(
                                //     FeedsEvent.updateFavorite(value.feed.id));
                              });
                              debugPrint("Removing favorite is working fine ");
                            },
                            error: (value) {
                              setState(() {
                                isFavorite = true;
                              });
                              showErrorSnackBar(
                                  "Unable to remove property from favorite.",
                                  context);
                            },
                          );
                        },
                        builder: ((context, state) {
                          return Container();
                        }),
                      ),
                      if (value.feed.category == "Vehicle")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${value.feed.make} ",
                              style: inputFieldLabelStyle,
                            ),
                            SizedBox(
                              width: 2.7.w,
                            ),
                            IconButton(
                              onPressed: () {
                                // TODO: Add to favorite list
                                if (!isFavorite) {
                                  context.read<AddToMyFavoriteBloc>().add(
                                        AddToMyFavoriteEvent.addToMyFavorite(
                                            value.feed.id),
                                      );
                                } else {
                                  context.read<RemoveFromMyFavoriteBloc>().add(
                                        RemoveFromMyFavoriteEvent
                                            .removeFromMyFavorite(
                                                value.feed.id),
                                      );
                                }
                              },
                              icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColors.nauticalCreatures),
                            )
                          ],
                        ),
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
                          if (value.feed.category == "Vehicle")
                            Text(
                              "NPR ${value.feed.price}",
                              style: inputFieldLabelMinStyle,
                            ),
                          if (value.feed.category != "Vehicle")
                            Text(
                              "NPR ${value.feed.price} - NPR ${value.feed.price}",
                              style: inputFieldLabelMinStyle,
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 1.7.h,
                      ),
                      if (value.feed.category != "Vehicle")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (value.feed.category == "House for rent" ||
                                    value.feed.category == "House for sale" ||
                                    value.feed.category ==
                                        "Short stay apartment" ||
                                    value.feed.category == "office")
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.room_preferences_outlined,
                                        size: 20,
                                        color: AppColors.nauticalCreatures,
                                      ),
                                      SizedBox(
                                        width: 3.3.w,
                                      ),
                                      Text(
                                        "${value.feed.rooms} Rooms",
                                        style: inputFieldHintStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                if (value.feed.category == "House for rent" ||
                                    value.feed.category == "House for sale" ||
                                    value.feed.category ==
                                        "Short stay apartment" ||
                                    value.feed.category == "office")
                                  SizedBox(
                                    height: 1.7.h,
                                  ),
                                if (value.feed.category == "House for rent" ||
                                    value.feed.category == "House for sale" ||
                                    value.feed.category ==
                                        "Short stay apartment")
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
                                        "${value.feed.beds}  Beds",
                                        style: inputFieldHintStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                if (value.feed.category == "House for rent" ||
                                    value.feed.category == "House for sale" ||
                                    value.feed.category ==
                                        "Short stay apartment")
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
                                      "${(value.feed.sizeWidth ?? 1) * (value.feed.sizeHeight ?? 1)}  SQ FT",
                                      style: inputFieldHintStyle.copyWith(
                                          fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.7.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (value.feed.category == "House for rent" ||
                                    value.feed.category == "House for sale" ||
                                    value.feed.category ==
                                        "Short stay apartment")
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.kitchen_outlined,
                                        size: 20,
                                        color: AppColors.nauticalCreatures,
                                      ),
                                      SizedBox(
                                        width: 3.3.w,
                                      ),
                                      Text(
                                        "${value.feed.kitchens} Kitchens",
                                        style: inputFieldHintStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                if (value.feed.category == "House for rent" ||
                                    value.feed.category == "House for sale" ||
                                    value.feed.category ==
                                        "Short stay apartment")
                                  SizedBox(
                                    height: 1.7.h,
                                  ),
                                if (value.feed.category == "House for rent" ||
                                    value.feed.category == "House for sale" ||
                                    value.feed.category ==
                                        "Short stay apartment")
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
                                        "${value.feed.baths} Baths",
                                        style: inputFieldHintStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                if (value.feed.category == "House for rent" ||
                                    value.feed.category == "House for sale" ||
                                    value.feed.category ==
                                        "Short stay apartment")
                                  SizedBox(
                                    height: 1.7.h,
                                  ),
                                if (value.feed.category == "Hall")
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.chair_alt_rounded,
                                        size: 20,
                                        color: AppColors.nauticalCreatures,
                                      ),
                                      SizedBox(
                                        width: 3.3.w,
                                      ),
                                      Text(
                                        "${value.feed.seats} Seats",
                                        style: inputFieldHintStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      if (value.feed.category == "Vehicle") ...[
                        vehiclePropertyBuilder("Model", "${value.feed.model}"),
                        SizedBox(
                          height: 1.7.h,
                        ),
                        vehiclePropertyBuilder("Color", "${value.feed.color}"),
                        SizedBox(
                          height: 1.7.h,
                        ),
                        vehiclePropertyBuilder(
                            "Fuel Type", "${value.feed.fuelType}"),
                        SizedBox(
                          height: 1.7.h,
                        ),
                        vehiclePropertyBuilder(
                            "Engine Size", "${value.feed.engineSize}"),
                        SizedBox(
                          height: 1.7.h,
                        ),
                        vehiclePropertyBuilder("VIN", "${value.feed.vin}"),
                        SizedBox(
                          height: 1.7.h,
                        ),
                        vehiclePropertyBuilder("Transmission Type",
                            "${value.feed.transmissionType}"),
                        SizedBox(
                          height: 1.7.h,
                        ),
                        vehiclePropertyBuilder(
                            "Mile Age", "${value.feed.mileage}"),
                      ],
                      SizedBox(
                        height: 3.7.h,
                      ),
                      Text(
                        "Location of the property",
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
                        margin: EdgeInsets.only(
                            bottom: 1.7.h, left: 0.1.w, right: 0.1.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.6.w, vertical: 1.1.h),
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
                                  "${value.feed.location.region} ",
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
                                  "${value.feed.location.district} ",
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
                                  "${value.feed.location.ward} ",
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
                      if (value.feed.category != "Vehicle") ...[
                        Text(
                          "Other features",
                          style: bodyTextStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(
                          height: 1.8.h,
                        ),
                        Material(
                          child: Wrap(
                            spacing: 6.0,
                            runSpacing: 6.0,
                            children: selectedList
                                .map((e) => ChipsBuilder(
                                      label: e,
                                    ))
                                .toList(),
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
                          "${value.feed.description}  ",
                          style: inputFieldHintStyle.copyWith(fontSize: 16.sp),
                        ),
                      ],
                      if (value.feed.category == "Vehicle") ...[
                        Text(
                          "Condition",
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
                          "${value.feed.condition} ",
                          style: inputFieldHintStyle.copyWith(fontSize: 16.sp),
                        ),
                      ],
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
                              offset:
                                  Offset(3, 3), // changes position of shadow
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
                            style:
                                linkTextStylePrimary.copyWith(fontSize: 14.sp),
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
                                    color:
                                        AppColors.buttonContainerWatermarkColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(3.5.w))),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Row vehiclePropertyBuilder(String name, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: inputFieldLabelStyle,
        ),
        Text(
          value,
          style: inputFieldLabelMinStyle,
        ),
      ],
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
