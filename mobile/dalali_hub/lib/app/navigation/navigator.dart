import 'dart:async';

import 'package:dalali_hub/app/pages/auth/login_with_google_apple_id.dart';
import 'package:dalali_hub/app/pages/broker_home/broker_home.dart';
import 'package:dalali_hub/app/pages/create_update_delete_realstate/add_realstate.dart';
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/add_vehicle.dart';
import 'package:dalali_hub/app/pages/customer_home/customer_home.dart';
import 'package:dalali_hub/app/pages/property_filter/propery_filter.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/property_detail_for_customer/realstate_detail.dart';
import 'package:dalali_hub/app/core/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart';
import 'package:dalali_hub/app/pages/auth/login.dart';
import 'package:dalali_hub/app/pages/auth/signup.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppRouter {
  final AuthCubit authCubit;
  AppRouter(this.authCubit);

  late final GoRouter router = GoRouter(
    initialLocation: authCubit.state.map(
      authenticated: (_) => AppRoutes.home,
      unauthenticated: (_) => AppRoutes.loginOptions,
      initial: (_) => AppRoutes.loginOptions,
      firstTime: (_) => AppRoutes.onBoarding,
    ),
    redirect: (context, state) => redirecter(context, state),
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        name: 'home',
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) =>
            const BottomNavigation(),
            // CreateVehiclePage(
            //     serviceName: "add vehicle",
            //     action: "Create",
            //     category: "vehicle"),
      ),
      GoRoute(
        name: 'signup',
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) =>
            const Signup(isEditingProfile: false),
      ),
      GoRoute(
        name: 'login',
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerHome,
        builder: (BuildContext context, GoRouterState state) =>
            const CustomerHomePage(),
      ),
      GoRoute(
        path: AppRoutes.houseFilter,
        builder: (BuildContext context, GoRouterState state) {
          // Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          return const PropertyFilter(serviceName: "House for rent");
        },
      ),
      GoRoute(
        path: AppRoutes.brokerHome,
        builder: (BuildContext context, GoRouterState state) {
          return const BrokerHomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.addRealstate,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CreateRealstatePage(
              serviceName: args["serviceName"],
              action: args["action"],
              category: args["category"]);
        },
      ),
      GoRoute(
        path: AppRoutes.propertyDetail,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return PropertyDetailPage(
            category: args["category"],
            feed: args["feed"],
            //  Feed(
            //   id: "id",
            //   title: "title",
            //   category: "category",
            //   photos: [],
            //   minPrice: 1,
            //   maxPrice: 2,
            //   size: 2,
            //   sizeUnit: "m",
            //   otherFeatures: [],
            //   description: "description",
            //   isApproved: false,
            //   location: Location(
            //     region: "region",
            //     district: "district",
            //     ward: "ward",
            //   ),
            // ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.loginOptions,
        builder: (BuildContext context, GoRouterState state) {
          return const LogInWithGoogleOrAppleId();
        },
      )
    ],
  );

  FutureOr<String?> redirecter(BuildContext context, GoRouterState state) {
    final bool loggedIn = authCubit.state.maybeWhen(
      authenticated: () => true,
      orElse: () => false,
    );

    final bool firstTime = authCubit.state.maybeWhen(
      firstTime: () => true,
      orElse: () => false,
    );

    debugPrint(firstTime.toString());

    if (firstTime) {
      authCubit.unauthenticated();
      return AppRoutes.onBoarding;
    }

    debugPrint('Matched Location: ${state.matchedLocation}');
    final bool loggingIn = state.matchedLocation != AppRoutes.loginOptions;
    if (!loggedIn) {
      return loggingIn ? null : AppRoutes.loginOptions;
    }

    return null;
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

extension GoRouterExtension on GoRouter {
  String get location {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
