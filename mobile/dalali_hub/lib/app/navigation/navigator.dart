import 'dart:async';

import 'package:dalali_hub/app/pages/auth/login_with_google_apple_id.dart';
import 'package:dalali_hub/app/pages/broker_home/broker_home.dart';
import 'package:dalali_hub/app/pages/create_hall/add_hall.dart';
import 'package:dalali_hub/app/pages/create_house/add_house.dart';
import 'package:dalali_hub/app/pages/create_office/create_office.dart';
import 'package:dalali_hub/app/pages/create_plot/add_plot.dart';
import 'package:dalali_hub/app/pages/customer_home/customer_home.dart';
import 'package:dalali_hub/app/pages/halls/hall_filter.dart';
import 'package:dalali_hub/app/pages/house_filter/house_filter.dart';
import 'package:dalali_hub/app/pages/lands/land_filter.dart';
import 'package:dalali_hub/app/pages/offices/offices_filter.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/property_detail_for_customer/property_detail.dart';
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
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return HouseFilter(serviceName: args["serviceName"]!);
        },
      ),
      GoRoute(
        path: AppRoutes.officeFilter,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return OfficeFilter(serviceName: args["serviceName"]!);
        },
      ),
      GoRoute(
        path: AppRoutes.hallFilter,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return HallFilter(serviceName: args["serviceName"]!);
        },
      ),
      GoRoute(
        path: AppRoutes.landFilter,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return LandFilter(serviceName: args["serviceName"]!);
        },
      ),
      GoRoute(
        path: AppRoutes.brokerHome,
        builder: (BuildContext context, GoRouterState state) {
          return const BrokerHomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.addHouse,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          // CreateHousePage(
          //   serviceName: args["serviceName"],
          //   action: args["action"],
          //   category: args["category"],
          // )
          return const CreateHousePage(serviceName: "Add house information", action : "Create", category: "House for rent",);
        },
      ),
      GoRoute(
        path: AppRoutes.addHall,
        builder: (BuildContext context, GoRouterState state) {
          return CreateHall(serviceName: "Add hall information");
        },
      ),
      GoRoute(
        path: AppRoutes.addOffice,
        builder: (BuildContext context, GoRouterState state) {
          return CreateOffice(serviceName: "Add office information");
        },
      ),
      GoRoute(
        path: AppRoutes.addPlot,
        builder: (BuildContext context, GoRouterState state) {
          return CreatePlot(serviceName: "Add Plot information");
        },
      ),
      GoRoute(
        path: AppRoutes.houseDetail,
        builder: (BuildContext context, GoRouterState state) {
          return const PropertyDetailPage();
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
