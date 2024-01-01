import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/hall_card.dart';
import 'package:dalali_hub/app/core/widgets/house_card.dart';
import 'package:dalali_hub/app/core/widgets/land_card.dart';
import 'package:dalali_hub/app/core/widgets/office_card.dart';
import 'package:dalali_hub/app/core/widgets/vehicle_card.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/broker_property_listing/bloc/my_listing/my_listing_bloc.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BrokerPropertyListingPage extends StatelessWidget {
  final String serviceName;

  const BrokerPropertyListingPage({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          if (serviceName == "Total listings") ...[
            BlocProvider(
              create: (context) => getIt.get<MyListingBloc>()
                ..add(
                  const MyListingEvent.myListing(null),
                ),
            ),
          ],
          if (serviceName == "Number of successful listings") ...[
            BlocProvider(
              create: (context) => getIt.get<MyListingBloc>()
                ..add(
                  const MyListingEvent.myListing(true),
                ),
            ),
          ]
        ],
        child: BrokerPropertyListing(
          serviceName: serviceName,
        ));
  }
}

class BrokerPropertyListing extends StatefulWidget {
  final String serviceName;
  const BrokerPropertyListing({super.key, required this.serviceName});

  @override
  State<BrokerPropertyListing> createState() => _BrokerPropertyListingState();
}

class _BrokerPropertyListingState extends State<BrokerPropertyListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: Padding(
          padding: EdgeInsets.only(left: 3.6.w, right: 3.6.w),
          child: DalaliAppBar(
            leadingButtonAction: () => {},
            titleWidget: Text(
              widget.serviceName,
              style: titleFont,
            ),
            trailingWidget: Container(
              width: 10.6.w,
              height: 4.6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.ultimateGray, width: .3.w),
              ),
              child: const Center(
                child: Icon(Icons.more_vert, color: AppColors.black),
              ),
            ),
          ),
        ),
      ),
      // extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
          left: 6.6.w,
          right: 6.6.w,
          bottom: 5.6.h,
        ),
        child: BlocBuilder<MyListingBloc, MyListingState>(
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => Container(),
              initial: (_) => Container(),
              loading: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
              success: (data) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.7.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data.feeds.length} Properties",
                        style: bodyTextStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black),
                      ),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.south_rounded,
                            ),
                            Icon(
                              Icons.north_rounded,
                            )
                          ])
                    ],
                  ),
                  SizedBox(height: 3.7.h),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.feeds.length,
                      itemBuilder: (context, index) {
                        if (data.feeds[index].category == "Hall") {
                          debugPrint("Hall seats");
                          debugPrint(data.feeds[index].seats.toString());
                          return HallCard(
                            title: data.feeds[index].title ?? "",
                            location: data.feeds[index].location.ward,
                            price: data.feeds[index].price.toString(),
                            sqft: data.feeds[index].sizeWidth.toString(),
                            seats: data.feeds[index].seats.toString(),
                            onTap: () {
                              context.push(AppRoutes.propertyDetail,
                                  extra: {"feedId": data.feeds[index].id});
                            },
                            photo: data.feeds[index].photos[0].secoureUrl,
                          );
                        } else if (data.feeds[index].category == "Office") {
                          return OfficeCard(
                              title: data.feeds[index].title ?? "",
                              location: data.feeds[index].location.ward,
                              price: data.feeds[index].price.toString(),
                              sqft: data.feeds[index].sizeWidth.toString(),
                              rooms: data.feeds[index].rooms.toString(),
                              onTap: () {
                                context.push(AppRoutes.propertyDetail,
                                    extra: {"feedId": data.feeds[index].id});
                              },
                              photo: data.feeds[index].photos[0].secoureUrl);
                        } else if (data.feeds[index].category == "Land") {
                          return LandCard(
                              title: data.feeds[index].title ?? "",
                              location: data.feeds[index].location.ward,
                              price: data.feeds[index].price.toString(),
                              sqft: data.feeds[index].sizeWidth.toString(),
                              onTap: () {
                                context.push(AppRoutes.propertyDetail,
                                    extra: {"feedId": data.feeds[index].id});
                              },
                              photo: data.feeds[index].photos[0].secoureUrl);
                        } else if (data.feeds[index].category == "Vehicle") {
                          debugPrint("Vehicle ${data.feeds[index].photos[0]}}");
                          return VehicleCard(
                              price: data.feeds[index].price.toString(),
                              make: data.feeds[index].make,
                              location: data.feeds[index].location.ward,
                              engineSize:
                                  data.feeds[index].engineSize.toString(),
                              color: data.feeds[index].color,
                              year: data.feeds[index].year.toString(),
                              onTap: () {
                                context.push(AppRoutes.propertyDetail,
                                    extra: {"feedId": data.feeds[index].id});
                              },
                              photo: data.feeds[index].photos[0].secoureUrl);
                        }
                        if (data.feeds[index].category == "House for rent" ||
                            data.feeds[index].category == "House for sell" ||
                            data.feeds[index].category ==
                                "Short stay apartment") {
                          return HouseCard(
                            title: data.feeds[index].title ?? "",
                            location: data.feeds[index].location.ward,
                            beds: data.feeds[index].beds.toString(),
                            baths: data.feeds[index].baths.toString(),
                            price: data.feeds[index].price.toString(),
                            sqft: data.feeds[index].sizeWidth.toString(),
                            onTap: () {
                              context.push(AppRoutes.propertyDetail,
                                  extra: {"feedId": data.feeds[index].id});
                            },
                            photo: data.feeds[index].photos[0].secoureUrl,
                          );
                        }
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text("Category doesn't exist"),
                        );
                      }),
                ],
              ),
              error: (error) => Center(
                child: Text(error.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}
