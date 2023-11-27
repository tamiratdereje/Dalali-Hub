import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/broker_home/widgets/broker_service_container.dart';
import 'package:dalali_hub/app/pages/broker_home/widgets/broker_statics.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BrokerHomePage extends StatefulWidget {
  const BrokerHomePage({super.key});

  @override
  State<BrokerHomePage> createState() => _BrokerHomePageState();
}

class _BrokerHomePageState extends State<BrokerHomePage> {
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
                      context.push(AppRoutes.addHouse,
                          extra: {"serviceName": "House for rent"});
                    },
                    serviceName: "House for rent House",
                  ),
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addHouse,
                          extra: {"serviceName": "House for sell"});
                    },
                    serviceName: "House for sell",
                  ),
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addOffice,
                          extra: {"serviceName": "Office for rent"});
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
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addHall,
                          extra: {"serviceName": "Halls for rent"});
                    },
                    serviceName: "Halls for rent",
                  ),
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addHouse,
                          extra: {"serviceName": "Short stay houses"});
                    },
                    serviceName: "Short stay houses",
                  ),
                  BrokerServiceContainer(
                    onTap: () {
                      context.push(AppRoutes.addOffice,
                          extra: {"serviceName": "Office Space for rent"});
                    },
                    serviceName: "Office for rent",
                  ),
                ],
              ),
              SizedBox(
                height: 1.4.h,
              ),
              BrokerServiceContainer(
                onTap: () {},
                serviceName: "Purchase/rent a vehicle",
              ),
              SizedBox(
                height: 3.9.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BrokerStatics(
                    amount: "17",
                    activity: "Total listings",
                  ),
                  SizedBox(
                    width: 13.3.w,
                  ),
                  BrokerStatics(
                    amount: "82",
                    activity: "Total views of current listing",
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
                    amount: "146",
                    activity: "All time listings",
                  ),
                  SizedBox(
                    width: 13.3.w,
                  ),
                  BrokerStatics(
                    amount: "670",
                    activity: "All time views",
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
