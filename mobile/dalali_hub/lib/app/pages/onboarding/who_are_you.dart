import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WhoAreYou extends StatelessWidget {
  const WhoAreYou({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 6.6.w, right: 6.6.w, bottom: 5.6.h, top: 9.3.h),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstants.dalaliLogoIllu,
            ),
            SizedBox(
              height: 10.4.h,
            ),
            Text(
              "Welcome",
              style: appBarTitleStyle,
            ),
            SizedBox(
              height: 0.7.h,
            ),
            Text(
              "Who are you?",
              style: appBarTitleStyle,
            ),
            SizedBox(
              height: 4.3.h,
            ),
            AppButtonPrimary(
              text: "Customer",
              onPressed: () {
                debugPrint("Customer");
                context
                    .read<AuthBloc>()
                    .add(const AuthEvent.updateAuthStatus());
                context.go(AppRoutes.loginOptions);
              },
            ),
            SizedBox(
              height: 3.3.h,
            ),
            Row(
              children: [
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.nauticalCreatures,
                  ),
                  child: SizedBox(
                    width: 37.5.w,
                  ),
                ),
                SizedBox(
                  width: 2.4.w,
                ),
                Text(
                  "or",
                  style: appBarTitleStyle.copyWith(
                    color: AppColors.welcomeOrTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 2.4.w,
                ),
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.nauticalCreatures,
                  ),
                  child: SizedBox(
                    width: 37.5.w,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.3.h,
            ),
            AppButtonPrimary(
              text: "Broker/Agent",
              onPressed: () {
                debugPrint("Broker/Agent");
                context
                    .read<AuthBloc>()
                    .add(const AuthEvent.updateAuthStatus());
                context.go(AppRoutes.loginOptions);
              },
            ),
            SizedBox(
              height: 7.7.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You don't have an account?",
                  style: inputFieldHintStyle,
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEvent.updateAuthStatus());
                    context.go(AppRoutes.register,
                        extra: {"isEditingProfile": false});
                  },
                  child: Text(
                    "Sign up here ",
                    style: inputFieldLabelMinStyle.copyWith(
                        color: AppColors.minBodyTextColor),
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
