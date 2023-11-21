import 'dart:ui';

import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/domain/type/types.dart';
import 'package:dalali_hub/domain/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showEmailOrPhoneForm({
  required TextEditingController textController,
  required GlobalKey<FormState> formKey,
  required BuildContext context,
  required OtpType otpType,
  required Function onSave,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
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
                  Text(
                    'Fill your ${otpType == OtpType.EMAIL ? 'email' : 'phone'} to get the code',
                    style: titleFont.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Form(
                    key: formKey,
                    child: AppInputField(
                      controller: textController,
                      label: otpType == OtpType.EMAIL
                          ? 'Email address'
                          : 'Phone number',
                      hint: otpType == OtpType.EMAIL
                          ? 'hello@gmail.com'
                          : '+255 65* *** ***',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (otpType == OtpType.PHONE) {
                          return validatePhoneNumber(value);
                        }
                        return validateEmail(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  AppButtonPrimary(
                      onPressed: () {
                        
                        if (formKey.currentState!.validate()) {
                          onSave();
                          Navigator.of(context).pop();
                        }
                      },
                      text: 'Save')
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
