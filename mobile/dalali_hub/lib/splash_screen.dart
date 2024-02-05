import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (authBlocContext, authBlocState) {
        authBlocState.whenOrNull(authenticated: () {
          context.go(AppRoutes.home);
        }, unauthenticated: () {
          context.go(AppRoutes.loginOptions);
        }, firstTime: () {
          context.go(AppRoutes.onBoarding);
        },
         error: () {
          context.go(AppRoutes.home);
         }
        );
      },
      child: const Scaffold(body: SizedBox.shrink()),
    );
  }
}
