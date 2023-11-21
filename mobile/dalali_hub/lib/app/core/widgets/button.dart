import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppButtonPrimary extends StatefulWidget {
  final void Function() onPressed;
  final String text;
  const AppButtonPrimary(
      {super.key, required this.onPressed, required this.text});

  @override
  State<AppButtonPrimary> createState() => _AppButtonPrimaryState();
}

class _AppButtonPrimaryState extends State<AppButtonPrimary> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.nauticalCreatures),
          child: Center(
              child: Text(widget.text, style: onPrimaryButtonTextStyle))),
      onTap: () => widget.onPressed(),
    );
  }
}

class AppButtonPrimaryCircular extends StatefulWidget {
  final Widget child;
  final void Function() onPressed;
  const AppButtonPrimaryCircular(
      {super.key, required this.child, required this.onPressed});

  @override
  State<AppButtonPrimaryCircular> createState() =>
      _AppButtonPrimaryCircularState();
}

class _AppButtonPrimaryCircularState extends State<AppButtonPrimaryCircular> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 5.h,
        width: 5.h,
        padding: EdgeInsets.all(1.5.h),
        decoration: BoxDecoration(
            color: AppColors.nauticalCreatures,
            borderRadius: BorderRadius.circular(50)),
        child: Center(child: widget.child),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  final Function onTap;

  const AppBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 6.w,
        height: 6.w,
        padding: EdgeInsets.fromLTRB(0.8.h, 0.5.h, 0.2.h, 0.5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.ultimateGray, width: .3.w)),
        child: const Center(
            child: Icon(Icons.arrow_back_ios, color: AppColors.black)),
      ),
    );
  }
}

class AppMenuButton extends StatelessWidget {
  final Function onTap;

  const AppMenuButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.ultimateGray, width: .3.w)),
          child: const Center(
              child: Icon(Icons.more_vert, color: AppColors.black))),
    );
  }
}
