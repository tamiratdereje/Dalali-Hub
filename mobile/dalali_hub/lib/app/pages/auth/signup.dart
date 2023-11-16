import 'package:dalali_hub/app/core/widgets/alert_dialog.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Signup extends StatefulWidget {
  bool isEditingProfile;
  Signup({super.key, this.isEditingProfile = false});
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            child: signupForm()));
  }

  Form signupForm() {
    return Form(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 3.h,
        ),
        Text(
          'Create your account',
          style: titleFont,
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: widget.fullNameController,
          label: 'Full name',
          hint: 'John Doe',
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: widget.emailController,
          label: 'Email address',
          hint: 'hello@gmail.com',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email is required';
            }
            return null;
          },
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: widget.phoneController,
          label: 'Phone number',
          prefixIcon: const Text('+880'),
          hint: '12345678',
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Phone number is required';
            }
            return null;
          },
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: widget.passwordController,
          label: 'Password',
          hint: '••••••••••',
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password is required';
            }
            return null;
          },
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: widget.confirmPasswordController,
          label: 'Confirm password',
          hint: '••••••••••',
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password is required';
            }
            return null;
          },
        ),
        SizedBox(
          height: 3.h,
        ),
        AppButtonPrimary(
            onPressed: () {
              showAppDialog(
                  context: context,
                  title: 'Congratulations!',
                  description:
                      'Your account is ready to use. You will be redirected to the Home poge in a few seconds.',
                  buttonLabel: 'Back to Sign in');
            },
            text: 'Sign up'),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: bodyTextStyle,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                ' Sign in',
                style: linkTextStylePrimary,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
