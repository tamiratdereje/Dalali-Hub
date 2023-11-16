import 'dart:async';

import 'package:dalali_hub/app/pages/onboarding/who_are_you.dart';
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
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          name: 'home',
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const Login()),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) => const Signup(),
      ),
      GoRoute(
        path: '/current',
        builder: (BuildContext context, GoRouterState state) => const WhoAreYou(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // final bool loggedIn = authCubit.state == const AuthState.authenticated();
      // final bool loggingIn = state.name == '/login';
      // if (!loggedIn) {
      //   return loggingIn ? null : '/login';
      // }
      // if (loggingIn) {
      //   return '/';
      // }
      // return null;
      return '/current';
    },
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
