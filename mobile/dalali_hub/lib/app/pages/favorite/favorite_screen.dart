import 'package:dalali_hub/app/core/widgets/hall_card.dart';
import 'package:dalali_hub/app/core/widgets/house_card.dart';
import 'package:dalali_hub/app/core/widgets/land_card.dart';
import 'package:dalali_hub/app/core/widgets/office_card.dart';
import 'package:dalali_hub/app/core/widgets/vehicle_card.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/favorite/bloc/get_my_favorites/get_my_favorites_bloc.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<GetMyFavoritesBloc>()
        ..add(const GetMyFavoritesEvent.getMyFavorites()),
      child: const Favorite(),
    );
  }
}

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Favorite properities",
              style: bodyTextStyle,
            ),
            BlocBuilder<GetMyFavoritesBloc, GetMyFavoritesState>(
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
    );
  }
}
