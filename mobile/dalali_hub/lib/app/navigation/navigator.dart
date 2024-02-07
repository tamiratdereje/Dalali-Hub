import 'dart:async';

import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart';
import 'package:dalali_hub/app/pages/auth/login_with_google_apple_id.dart';
import 'package:dalali_hub/app/pages/broker_home/broker_home.dart';
import 'package:dalali_hub/app/pages/broker_property_listing/broker_property_listing.dart';
import 'package:dalali_hub/app/pages/chat/contact_screen.dart';
import 'package:dalali_hub/app/pages/chat/message_screen.dart';
import 'package:dalali_hub/app/pages/create_update_delete_realstate/add_realstate.dart';
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/add_vehicle.dart';
import 'package:dalali_hub/app/pages/customer_home/customer_home.dart';
import 'package:dalali_hub/app/pages/favorite/favorite_screen.dart';
import 'package:dalali_hub/app/pages/forget_password/create_new_password.dart';
import 'package:dalali_hub/app/pages/forget_password/forgot_password.dart';
import 'package:dalali_hub/app/pages/forget_password/verify_otp.dart';
import 'package:dalali_hub/app/pages/onboarding/who_are_you.dart';
import 'package:dalali_hub/app/pages/profile/profile.dart';
import 'package:dalali_hub/app/pages/property_filter/propery_filter.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/property_detail_for_customer/property_detail.dart';
import 'package:dalali_hub/app/core/widgets/bottom_nav.dart';
import 'package:dalali_hub/app/pages/property_filter/search_result.dart';
import 'package:dalali_hub/data/remote/model/realm/room_wrapper.dart';
import 'package:dalali_hub/domain/type/types.dart';
import 'package:dalali_hub/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dalali_hub/app/pages/auth/login.dart';
import 'package:dalali_hub/app/pages/auth/signup.dart';
import 'package:injectable/injectable.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

@singleton
class AppRouter {
  final AuthBloc authCubit;
  AppRouter(this.authCubit);

  var allowedRoutes = {
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.otp,
  };

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) => redirecter(context, state),
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          path: AppRoutes.splashScreen,
          builder: (context, state) {
            return const SplashScreen();
          }),
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
          builder: (BuildContext context, GoRouterState state) {
            Map<String, dynamic> args = state.extra as Map<String, dynamic>;
            return Signup(
              isEditingProfile: args["isEditingProfile"],
            );
          }),
      GoRoute(
        name: 'profile',
        path: AppRoutes.profile,
        builder: (BuildContext context, GoRouterState state) => const Profile(),
      ),
      GoRoute(
        name: 'login',
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
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
            return const CreateNewPassword();
          }),
      GoRoute(
        path: AppRoutes.customerHome,
        builder: (BuildContext context, GoRouterState state) =>
            const CustomerHomePage(),
      ),
      GoRoute(
        path: AppRoutes.propertyFilter,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          return PropertyFilterPage(serviceName: args["serviceName"]);
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
            category: args["category"],
            realstate: args["realstate"] != null ? args["realstate"]! : null,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.addVehicle,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return CreateVehiclePage(
            serviceName: args["serviceName"],
            action: args["action"],
            category: args["category"],
            vehicle: args["vehicle"] != null ? args["vehicle"]! : null,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.filterResult,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return FilterResultPage(
            feed: args["propertyList"],
          );
        },
      ),
      GoRoute(
        path: AppRoutes.propertyDetail,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          return PropertyDetailPage(
            feedId: args["feedId"],
          );
        },
      ),
      GoRoute(
        path: AppRoutes.loginOptions,
        builder: (BuildContext context, GoRouterState state) {
          return const LogInWithGoogleOrAppleId();
        },
      ),
      GoRoute(
        name: 'propertyListing',
        path: AppRoutes.propertyListing,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return BrokerPropertyListingPage(
            serviceName: args["serviceName"],
          );
        },
      ),
      GoRoute(
        name: 'favorites',
        path: AppRoutes.favorites,
        builder: (BuildContext context, GoRouterState state) {
          return const Favorite();
        },
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
          path: AppRoutes.chatRoom,
          builder: (BuildContext context, GoRouterState state) {
            final Map<String, dynamic> args =
                state.extra as Map<String, dynamic>;
            return ChatRoom(
              room: args['room'] as RoomWrapper,
            );
          }),
      GoRoute(
        path: AppRoutes.onBoarding,
        builder: (BuildContext context, GoRouterState state) {
          return const WhoAreYou();
        },
      ),
      GoRoute(
        path: AppRoutes.contacts,
        builder: (BuildContext context, GoRouterState state) {
          return const ContactScreem();
        },
      )
    ],
  );

  FutureOr<String?> redirecter(BuildContext context, GoRouterState state) {
    return authCubit.state.maybeWhen(
      initial: () => AppRoutes.splashScreen,
      unauthenticated: () {
        debugPrint(state.matchedLocation);
        if (!allowedRoutes.contains(state.matchedLocation)) {
          return AppRoutes.loginOptions;
        }
        return null;
      },
      firstTime: () {
        return AppRoutes.onBoarding;
      },
      orElse: () => null,
    );
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
