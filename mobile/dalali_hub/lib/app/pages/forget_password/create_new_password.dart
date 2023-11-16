import 'package:dalali_hub/app/core/widgets/alert_dialog.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/core/widgets/tactile_button.dart';
import 'package:dalali_hub/app/pages/forget_password/widgets/forgot_password_appbar.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/color_constants.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ForgotPasswordAppBar(
        title: "Create a new password",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 6.6.w,
          right: 6.6.w,
          top: 5.1.h,
          bottom: 5.6.h,
        ),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              ImageConstants.createNewPassword,
            ),
            SizedBox(
              height: 5.7.h,
            ),
            Text(
              "Create a new password",
              style: boldbodyTextStyle,
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    AppInputField(
                      controller: newPasswordController,
                      label: 'New password',
                      hint: '******',
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    AppInputField(
                      controller: repeatPasswordController,
                      label: 'Repeat new password',
                      hint: '*******',
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        // if (value != newPasswordController.text) {
                        //   return 'Password does not match';
                        // }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 3.4.h,
                    ),
                    AppButtonPrimary(
                      text: "Continue",
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          debugPrint('form is not valid');
                          return;
                        }
                        if (repeatPasswordController.text !=
                            newPasswordController.text) {
                          showAppDialog(
                              context: context,
                              errorAlert: true,
                              title: 'Opps, Wrong password',
                              description: 'You have entered a wrong password',
                              buttonLabel: 'Try again');
                        } else {
                          showAppDialog(
                              context: context,
                              title: 'Congratulations!',
                              description: 'Your account is ready',
                              buttonLabel: 'Log in');
                        }
                      },
                    ),
                  ],
                )),
          ],
        )),
      ),
    );
    
  }
}
