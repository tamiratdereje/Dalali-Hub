import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/customer_service_container.dart';
import 'package:dalali_hub/app/pages/cutomer_home/widgets/house_card.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
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
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return HouseCard(
                      onTap: () {
                        context.push(
                          AppRoutes.houseDetail,
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
