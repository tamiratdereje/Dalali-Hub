import 'dart:async';

import 'package:dalali_hub/app/pages/cutomer_home/customer_home.dart';
import 'package:dalali_hub/app/pages/halls/hall_filter.dart';
import 'package:dalali_hub/app/pages/house_filter/house_filter.dart';
import 'package:dalali_hub/app/pages/lands/land_filter.dart';
import 'package:dalali_hub/app/pages/offices/offices_filter.dart';
import 'package:dalali_hub/app/pages/onboarding/who_are_you.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
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
    initialLocation: AppRoutes.customerHome,
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          path: AppRoutes.home,
          builder: (BuildContext context, GoRouterState state) => Login()),
      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) =>
            const CustomerHomePage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) => Login(),
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
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   final bool loggedIn = authCubit.state == const AuthState.authenticated();
    //   final bool loggingIn = state.name == AppRoutes.login;
    //   if (!loggedIn) {
    //     return loggingIn ? null : AppRoutes.register;
    //   }
    //   if (loggingIn) {
    //     return AppRoutes.home;
    //   }
    //   return null;
    // },
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
  );
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
