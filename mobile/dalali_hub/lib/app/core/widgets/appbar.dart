import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class DalaliAppBar extends StatefulWidget {
  final Function leadingButtonAction;
  final Widget? titleWidget;
  final Widget? trailingWidget;
  final Function? onTapTrailingButton;
  const DalaliAppBar(
      {super.key,
      required this.leadingButtonAction,
      this.titleWidget,
      this.trailingWidget,
      this.onTapTrailingButton});

  @override
  State<DalaliAppBar> createState() => _DalaliAppBarState();
}

class _DalaliAppBarState extends State<DalaliAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      margin: EdgeInsets.only(
        top: 3.7.h,
      ),
      child: Center(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBackButton(
            onTap: widget.leadingButtonAction,
            color: AppColors.doctor.withOpacity(0.3),
          ),
          title: widget.titleWidget,
          centerTitle: true,
          actions: widget.trailingWidget != null
              ? [
                  PopupMenuButton<int>(
                    color: Colors.white,

                    iconSize: 5.w,
                    initialValue: 1,
                    // Callback that sets the selected popup menu item.
                    onSelected: (value) {
                      debugPrint("selected menu $value");
                      if (value == 1) {
                        debugPrint("Then what man ");
                        widget.onTapTrailingButton!('Edit');
                      } else if (value == 2) {
                        widget.onTapTrailingButton!('Delete');
                      }
                    },

                    constraints: BoxConstraints(
                      minWidth: 10.w,
                      maxWidth: 20.w,
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          'Edit',
                          style: bodyTextStyle,
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          'Delete',
                          style: bodyTextStyle,
                        ),
                      ),
                    ],
                    child: widget.trailingWidget,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
