import 'dart:async';

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
    initialLocation: authCubit.state.map(
      authenticated: (_) => AppRoutes.home,
      unauthenticated: (_) => AppRoutes.login,
      initial: (_) => AppRoutes.login,
    ),
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          path: AppRoutes.home,
          builder: (BuildContext context, GoRouterState state) => Login()),
      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) => Signup(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) => Login(),
      )
    ],
    redirect: (context, state) => redirecter(context, state),
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
  );

  FutureOr<String?> redirecter(BuildContext context, GoRouterState state) {
    final bool loggedIn = authCubit.state.map(
      authenticated: (_) => true,
      unauthenticated: (_) => false,
      initial: (_) => false,
    );
    
    final bool loggingIn = state.name == AppRoutes.login;
    if (!loggedIn) {
      return loggingIn ? null : AppRoutes.register;
    }
    if (loggingIn) {
      return AppRoutes.home;
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
