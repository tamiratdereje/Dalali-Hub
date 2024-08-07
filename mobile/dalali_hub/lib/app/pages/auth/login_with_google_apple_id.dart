import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/auth/widgets/sign_in_container.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LogInWithGoogleOrAppleId extends StatefulWidget {
  const LogInWithGoogleOrAppleId({super.key});

  @override
  State<LogInWithGoogleOrAppleId> createState() =>
      _LogInWithGoogleOrAppleIdState();
}

class _LogInWithGoogleOrAppleIdState extends State<LogInWithGoogleOrAppleId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: DalaliAppBar(
          leadingButtonAction: () {},
          titleWidget: Text(
            'Welcome',
            style: titleFont,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 6.w,
        ),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.h,
            ),
            SvgPicture.asset(
              ImageConstants.dalaliLogoIllu,
            ),
            SizedBox(
              height: 11.9.h,
            ),
            SingInContainer(
              title: "Sign in using Google account",
              icon: ImageConstants.googleLogo,
              tap: () {},
              color: AppColors.selectedContainer,
            ),
            SizedBox(
              height: 1.2.h,
            ),
            SingInContainer(
              title: "Sign in using apple ID",
              icon: ImageConstants.appleLogo,
              tap: () {},
              color: AppColors.selectedContainer,
            ),
            SizedBox(
              height: 2.8.h,
            ),
            Row(
              children: [
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: AppColors.dividerLineSemiBoldColor,
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
                  style: boldbodyTextStyle.copyWith(
                    color: AppColors.semiBoldContainerColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 2.4.w,
                ),
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: AppColors.dividerLineSemiBoldColor,
                  ),
                  child: SizedBox(
                    width: 37.5.w,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.8.h,
            ),
            SizedBox(
              height: 4.5.h,
            ),
            AppButtonPrimary(
              text: "Log in with existing account",
              onPressed: () => context.go(AppRoutes.login),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: inputFieldLabelStyle,
                ),
                TextButton(
                  onPressed: () {
                    context.push(AppRoutes.register);
                  },
                  child: Text(
                    "Click here ",
                    style: linkTextStylePrimary,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 6.h,
            )
          ],
        )),
      ),
    );
  }
}
