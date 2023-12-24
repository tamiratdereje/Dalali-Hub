import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart';
import 'package:dalali_hub/app/pages/settings/widgets/setting_tile.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: DalaliAppBar(
          leadingButtonAction: () => context.pop(),
          titleWidget: Text(
            'Settings',
            style: titleFont,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            const SettingTileList(),
            SizedBox(height: 3.h),
            AppButtonPrimary(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                context.read<LogoutBloc>().add(const LogoutEvent.logout());
                context.go(AppRoutes.login);
              },
              text: 'Sign Out',

              textStyle: onPrimaryButtonTextStyle.copyWith(color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
