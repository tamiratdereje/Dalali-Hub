import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/pages/forget_password/widgets/forgot_password_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class CodeConfirmation extends StatefulWidget {
  const CodeConfirmation({super.key});

  @override
  State<CodeConfirmation> createState() => _CodeConfirmationState();
}

class _CodeConfirmationState extends State<CodeConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ForgotPasswordAppBar(
        title: "Code Confirmation",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 6.6.w,
          right: 6.6.w,
          bottom: 5.6.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 7.4.h,
              ),
              Text(
                "The Code has been sent to",
                textAlign: TextAlign.center,
                style: inputFieldHintStyle.copyWith(fontSize: 16.sp),
              ),
              Text(
                "+255 754 ****** 61",
                textAlign: TextAlign.center,
                style: inputFieldLabelMinStyle.copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 4.5.h),
              OtpTextField(
                fillColor: AppColors.ultimateGray.withOpacity(0.2),
                textStyle:
                    bodyTextStyle.copyWith(color: AppColors.optTextColor),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                showCursor: false,
                showFieldAsBox: true,
                fieldWidth: 64,
                borderRadius: BorderRadius.circular(16),
                filled: true,
                keyboardType: TextInputType.number,
                borderColor: Colors.transparent,
                enabledBorderColor: Colors.transparent,
                numberOfFields: 4,
                focusedBorderColor: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 3.6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive the code?",
                      textAlign: TextAlign.center,
                      style: buttonContainerBoldStyle.copyWith(
                          color: AppColors.minBodyTextColor, fontSize: 16.sp)),
                  TextButton(
                    child: Text("Resend Code",
                        textAlign: TextAlign.center,
                        style: buttonContainerBoldStyle.copyWith(
                            color: AppColors.successColor, fontSize: 16.sp)),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 14.1.h),
              AppButtonPrimary(
                text: "Confirm code",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
