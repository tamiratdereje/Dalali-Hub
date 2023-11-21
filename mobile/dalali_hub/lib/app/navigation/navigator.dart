import 'dart:async';

import 'package:dalali_hub/app/core/widgets/bottom_nav.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/forget_password/create_new_password.dart';
import 'package:dalali_hub/app/pages/forget_password/forgot_password.dart';
import 'package:dalali_hub/app/pages/forget_password/verify_otp.dart';
import 'package:dalali_hub/app/pages/home/home.dart';
import 'package:dalali_hub/domain/entity/verify_otp.dart';
import 'package:dalali_hub/domain/type/types.dart';
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
    redirect: (context, state) => redirecter(context, state),
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          name: 'home',
          path: AppRoutes.home,
          builder: (BuildContext context, GoRouterState state) =>
              const BottomNavigation()),
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
        name: 'otp',
        path: AppRoutes.otp,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return VerifyOTP(
              email: args['email'] as String?,
              phone: args['phone'] as String?,
              otpPurpose: args['otpPurpose'] as OtpPurpose,
              otpType: args['otpType'] as OtpType);
        },
      ),
      GoRoute(
        name: 'forget_password',
        path: AppRoutes.forgotPassword,
        builder: (BuildContext context, GoRouterState state) =>
            const ForgotPassword(),
      ),
      GoRoute(
          name: 'create_new_password',
          path: AppRoutes.createNewPassword,
          builder: (BuildContext context, GoRouterState state) {
            Map<String, dynamic> args =
                state.extra as Map<String, dynamic>;
                
            return const CreateNewPassword();
          })
    ],
  );

  FutureOr<String?> redirecter(BuildContext context, GoRouterState state) {
    final bool loggedIn = authCubit.state.map(
      authenticated: (_) => true,
      unauthenticated: (_) => false,
      initial: (_) => false,
    );

    debugPrint('Matched Location: ${state.matchedLocation}');

    final bool loggingIn = state.matchedLocation != AppRoutes.login;
    if (!loggedIn) {
      return loggingIn ? null : AppRoutes.login;
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
