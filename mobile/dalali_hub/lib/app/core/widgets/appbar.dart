import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DalaliAppBar extends StatelessWidget {
  final Function leadingButtonAction;
  final Widget? titleWidget;
  final Widget? trailingWidget;
  const DalaliAppBar(
      {super.key,
      required this.leadingButtonAction,
      this.titleWidget,
      this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AppBackButton(
          onTap: leadingButtonAction,
        ),
        title: titleWidget,
        centerTitle: true,
        actions: trailingWidget != null ? [trailingWidget!] : null,
      ),
    );
  }
}
