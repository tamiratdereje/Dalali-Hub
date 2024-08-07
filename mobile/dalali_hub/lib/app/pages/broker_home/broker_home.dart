import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/broker_home/bloc/get_my_stat/get_my_stat_bloc.dart';
import 'package:dalali_hub/app/pages/broker_home/widgets/broker_service_container.dart';
import 'package:dalali_hub/app/pages/broker_home/widgets/broker_statics.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BrokerHomePage extends StatelessWidget {
  const BrokerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            getIt.get<GetMyStatBloc>()..add(const GetMyStatEvent.getMyStat()),
      ),
    ], child: const BrokerHome());
  }
}

class BrokerHome extends StatefulWidget {
  const BrokerHome({super.key});

  @override
  State<BrokerHome> createState() => _BrokerHomeState();
}

class _BrokerHomeState extends State<BrokerHome> {
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
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addRealstate, extra: {
                        "serviceName": "House for rent",
                        "action": "Create",
                        "category": "House for rent"
                      });
                    },
                    serviceName: "House for rent House",
                  ),
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addRealstate, extra: {
                        "serviceName": "House for sell",
                        "action": "Create",
                        "category": "House for sell"
                      });
                    },
                    serviceName: "House for sell",
                  ),
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addRealstate, extra: {
                        "serviceName": "Office",
                        "action": "Create",
                        "category": "Office"
                      });
                    },
                    serviceName: "Office",
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
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addRealstate, extra: {
                        "serviceName": "Hall",
                        "action": "Create",
                        "category": "Hall"
                      });
                    },
                    serviceName: "Hall",
                  ),
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addRealstate, extra: {
                        "serviceName": "Short stay apartment",
                        "action": "Create",
                        "category": "Short stay apartment"
                      });
                    },
                    serviceName: "Short stay apartment",
                  ),
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addRealstate, extra: {
                        "serviceName": "Land",
                        "action": "Create",
                        "category": "Land"
                      });
                    },
                    serviceName: "Land",
                  ),
                ],
              ),
              SizedBox(
                height: 1.4.h,
              ),
              BrokerServiceContainer(
                onTap: () {
                  context.push(AppRoutes.addVehicle, extra: {
                    "serviceName": "Vehicle",
                    "action": "Create",
                    "category": "Vehicle"
                  });
                },
                serviceName: "Vehicle",
              ),
              SizedBox(
                height: 3.9.h,
              ),
              BlocConsumer<GetMyStatBloc, GetMyStatState>(
                  builder: (context, state) {
                    return state.maybeMap(
                      orElse: () => Container(),
                      initial: (value) => Container(),
                      loading: (value) {
                        return const CircularProgressIndicator();
                      },
                      success: (value) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BrokerStatics(
                                  amount:
                                      value.brokerStat.totalListing.toString(),
                                  activity: "Total listings",
                                  onTap: () {
                                    context.push(AppRoutes.propertyListing,
                                        extra: {
                                          "serviceName": "Total listings"
                                        });
                                  },
                                ),
                                SizedBox(
                                  width: 13.3.w,
                                ),
                                BrokerStatics(
                                  amount: value.brokerStat.totalNumOfView
                                      .toString(),
                                  activity: "Total Number of views.",
                                  onTap: () {},
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1.8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BrokerStatics(
                                  amount: value.brokerStat.numberOfFavorite
                                      .toString(),
                                  activity: "Number of favorite listings",
                                  onTap: () {
                                    context.push(AppRoutes.favorites);
                                  },
                                ),
                                SizedBox(
                                  width: 13.3.w,
                                ),
                                BrokerStatics(
                                  amount: value.brokerStat.numberOfSuccedListing
                                      .toString(),
                                  activity: "Number of successful listings",
                                  onTap: () {
                                    context.push(
                                      AppRoutes.propertyListing,
                                      extra: {
                                        "serviceName":
                                            "Number of successful listings"
                                      },
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        );
                      },
                      error: (value) {
                        return const Text("Error while loading the stat");
                      },
                    );
                  },
                  listener: (context, state) {}),
            ],
          ),
        ),
      ),
    );
  }
}
