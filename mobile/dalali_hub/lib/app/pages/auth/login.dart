import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Login extends StatefulWidget {
  Login({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              signinIllustration,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              'Sign in your account',
              style: titleFont,
            ),
            SizedBox(
              height: 3.h,
            ),
            loginForm(),
          ],
        ),
      ))),
    );
  }

  Form loginForm() {
    return Form(
              child: Column(
            children: [
              AppInputField(
                controller: widget.emailController,
                label: 'Email address',
                hint: 'hello@gmail.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  // TODO: add email validation
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 1.h,
              ),
              AppInputField(
                controller: widget.passwordController,
                label: 'Password',
                hint: '••••••••••',
                obscureText: true,
                validator: (value) {
                  // TODO: add password validation
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 1.h,
              ),
              AppButtonPrimary(onPressed: () {}, text: 'Sign in'),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot the password?',
                      style: linkTextStylePrimary,
                    ),
                  ),
                  Text(
                    ' or continue with',
                    style: bodyTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              socialMediaAuth(),
            ],
          ));
  }

  Row socialMediaAuth() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButtonPrimaryCircular(
                  onPressed: () {},
                  child: SvgPicture.asset(facebookLogo),
                ),
                SizedBox(
                  width: 6.w,
                ),
                AppButtonPrimaryCircular(
                  onPressed: () {},
                  child: SvgPicture.asset(googleLogo),
                ),
                SizedBox(
                  width: 6.w,
                ),
                AppButtonPrimaryCircular(
                  onPressed: () {},
                  child: SvgPicture.asset(appleLogo),
                ),
              ],
            );
  }
}
