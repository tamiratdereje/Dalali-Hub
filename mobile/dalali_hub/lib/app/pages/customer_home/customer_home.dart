import 'package:dalali_hub/app/core/widgets/hall_card.dart';
import 'package:dalali_hub/app/core/widgets/house_card.dart';
import 'package:dalali_hub/app/core/widgets/land_card.dart';
import 'package:dalali_hub/app/core/widgets/office_card.dart';
import 'package:dalali_hub/app/core/widgets/vehicle_card.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/customer_home/bloc/feeds/feeds_bloc.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_service_container.dart';

import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<FeedsBloc>()..add(const FeedsEvent.feeds()),
      child: const CustomerHome(),
    );
  }
}

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomerAppBar(title: "Choose a service"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.houseFilter,
                          extra: {"serviceName": "House for rent"});
                    },
                    serviceName: "House for rent House",
                  ),
                  CustomerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.houseFilter,
                          extra: {"serviceName": "House for sell"});
                    },
                    serviceName: "House for sell",
                  ),
                ],
              ),
              SizedBox(
                height: 1.4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.houseFilter,
                          extra: {"serviceName": "Short stay houses"});
                    },
                    serviceName: "Short stay houses",
                  ),
                  CustomerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.officeFilter,
                          extra: {"serviceName": "Office Space for rent"});
                    },
                    serviceName: "Office for rent",
                  ),
                ],
              ),
              SizedBox(
                height: 1.4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.hallFilter,
                          extra: {"serviceName": "Function halls"});
                    },
                    serviceName: "Halls for rent",
                  ),
                  CustomerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.landFilter,
                          extra: {"serviceName": "Land for sell"});
                    },
                    serviceName: "Plots and land for sell",
                  ),
                ],
              ),
              SizedBox(
                height: 1.4.h,
              ),
              CustomerServiceContainer(
                onTap: () {},
                serviceName: "Purchase/rent a vehicle",
              ),
              SizedBox(
                height: 3.9.h,
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
                height: 2.3.h,
              ),
              BlocBuilder<FeedsBloc, FeedsState>(
                builder: (context, state) {
                  return state.maybeMap(
                    orElse: () => Container(),
                    initial: (_) => Container(),
                    loading: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    success: (data) => ListView.builder(
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
                              price: data.feeds[index].maxPrice.toString(),
                              sqft: data.feeds[index].size.toString(),
                              seats: data.feeds[index].seats.toString(),
                              onTap: () {
                                context.push(AppRoutes.propertyDetail, extra: {
                                  "feed": data.feeds[index],
                                  "category": data.feeds[index].category
                                });
                              },
                              photo: data.feeds[index].photos[0].secoureUrl,
                            );
                          } else if (data.feeds[index].category == "Office") {
                            return OfficeCard(
                                title: data.feeds[index].title ?? "",
                                location: data.feeds[index].location.ward,
                                price: data.feeds[index].maxPrice.toString(),
                                sqft: data.feeds[index].size.toString(),
                                rooms: data.feeds[index].rooms.toString(),
                                onTap: () {
                                  context.push(AppRoutes.propertyDetail,
                                      extra: {
                                        "feed": data.feeds[index],
                                        "category": data.feeds[index].category
                                      });
                                },
                                 photo: data.feeds[index].photos[0].secoureUrl);
                          } else if (data.feeds[index].category == "Land") {
                            return LandCard(
                                title: data.feeds[index].title ?? "",
                                location: data.feeds[index].location.ward,
                                price: data.feeds[index].maxPrice.toString(),
                                sqft: data.feeds[index].size.toString(),
                                onTap: () {
                                  context.push(AppRoutes.propertyDetail,
                                      extra: {
                                        "feed": data.feeds[index],
                                        "category": data.feeds[index].category
                                      });
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
                                      extra: {
                                        "feed": data.feeds[index],
                                        "category": data.feeds[index].category
                                      });
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
                              price: data.feeds[index].maxPrice.toString(),
                              sqft: data.feeds[index].size.toString(),
                              onTap: () {
                                context.push(AppRoutes.propertyDetail, extra: {
                                  "feed": data.feeds[index],
                                  "category": data.feeds[index].category
                                });
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
