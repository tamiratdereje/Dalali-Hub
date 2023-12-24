import 'dart:io';
import 'dart:ui';

import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<String?> showYesOrNoDialog({
  required BuildContext context,
  bool errorAlert = false,
  required String title,
  required String description,
  String? yesButtonLabel,
  String? noButtonLabel,
  String? image,
  required Function onButtonPressed,
}) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.h, sigmaY: 1.h),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.h)),
          content: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 10.h,
                    width: 10.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.file(File(image!), fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    title,
                    style: titleFont.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(description,
                      textAlign: TextAlign.center,
                      style: errorAlert
                          ? inputFieldLabelMinStyle.copyWith(
                              color: AppColors.errorColor,
                            )
                          : inputFieldLabelMinStyle.copyWith(
                              color: AppColors.successColor,
                            )),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButtonPrimary(
                        
                        onPressed: () {
                          Navigator.of(context).pop("No");
                        },
                        textStyle: onPrimaryButtonTextStyle.copyWith(
                            color: AppColors.white),
                        text: noButtonLabel ?? 'No',
                      ),
                      AppButtonPrimary(
                        onPressed: () {
                          Navigator.of(context).pop("Yes");
                        },
                        text: yesButtonLabel ?? "Yes",
                        textStyle: onPrimaryButtonTextStyle.copyWith(
                            color: AppColors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class DialogIcon extends StatelessWidget {
  final bool isError;
  const DialogIcon({super.key, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      width: 10.h,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            isError ? Colors.red.shade200 : Colors.green.shade200,
            isError ? Colors.red : Colors.green,
          ]),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
          child: Icon(
        isError ? Icons.close : Icons.check_sharp,
        size: 5.h,
        color: Colors.white,
      )),
    );
  }
}
