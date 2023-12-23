import 'dart:io';

import 'package:dalali_hub/app/core/widgets/alert_dialog.dart';
import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/drop_down_input_field.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/auth/bloc/signup/signup_bloc.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/domain/entity/signup.dart';
import 'package:dalali_hub/domain/type/types.dart';
import 'package:dalali_hub/domain/validators/validators.dart';
import 'package:dalali_hub/injection.dart';
import 'package:dalali_hub/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Signup extends StatefulWidget {
  final bool isEditingProfile;
  const Signup({super.key, required this.isEditingProfile});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late bool isEditingProfile;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final List<String> genders =
      Gender.values.map((e) => e.name.capitalize()).toList();
  final List<String> regions =
      Region.values.map((e) => e.name.capitalize()).toList();
  String gender = Gender.values[0].name.capitalize();
  String region = Region.values[0].name.capitalize();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onGenderChange(String g) {
    setState(() {
      debugPrint('Gender: $g');
      gender = g;
    });
  }

  void onRegionChange(String r) {
    setState(() {
      region = r;
    });
  }

  @override
  void initState() {
    super.initState();
    isEditingProfile = widget.isEditingProfile;
    if (isEditingProfile) {
      firstNameController.text = 'Tamirat';
      lastNameController.text = 'Dereje';
      middleNameController.text = 'M.';
      emailController.text = "tamiratdereje167@gmail.com";
      phoneController.text = "0947408989";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (context) => getIt<SignupBloc>(),
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(8.h),
              child: DalaliAppBar(
                leadingButtonAction: () => context.pop(),
                titleWidget: Text(
                 isEditingProfile ? "Edit your profile" : 'Create an account',
                  style: titleFont,
                ),
              )),
          body: BlocConsumer<SignupBloc, SignupState>(
            listener: (context, state) {
              state.mapOrNull(
                success: (value) {
                  showAppDialog(
                      context: context,
                      title: 'Congratulation!',
                      description: 'Your account is ready',
                      buttonLabel: 'Login');
                  // sleep for 1 sec
                  context.go(AppRoutes.login);
                },
                error: (error) => WidgetsBinding.instance.addPostFrameCallback(
                    (_) => showErrorSnackBar(error.message, context)),
              );
            },
            builder: (context, state) {
              return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                  child: signupForm());
            },
          )),
    );
  }

  Form signupForm() {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 2.h,
        ),
        AppInputField(
          controller: firstNameController,
          label: 'First name',
          hint: 'John',
          keyboardType: TextInputType.name,
          validator: (value) => validateName(value),
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: middleNameController,
          label: 'Middle name',
          hint: 'F.',
          keyboardType: TextInputType.name,
          validator: (value) => validateName(value),
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: lastNameController,
          label: 'Sir name',
          hint: 'Doe',
          keyboardType: TextInputType.name,
          validator: (value) => validateName(value),
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: emailController,
          label: 'Email address',
          hint: 'hello@gmail.com',
          keyboardType: TextInputType.emailAddress,
          validator: (value) => validateEmail(value),
        ),
        SizedBox(
          height: 3.h,
        ),
        AppInputField(
          controller: phoneController,
          label: 'Phone number',
          prefixIcon: const Text('+255'),
          hint: '12345678',
          keyboardType: TextInputType.phone,
          validator: (value) => validatePhoneNumber('+255$value'),
        ),
        SizedBox(
          height: 3.h,
        ),
        AppDropDownInputField(
          items: genders,
          label: 'Gender',
          onChanged: (p0) => onGenderChange(p0),
        ),
        SizedBox(
          height: 3.h,
        ),
        AppDropDownInputField(
            items: regions,
            label: 'Region',
            onChanged: (p0) => onRegionChange(p0)),
        SizedBox(
          height: 3.h,
        ),
        if (!isEditingProfile)
          AppInputField(
            controller: passwordController,
            label: 'Password',
            hint: '••••••••••',
            obscureText: true,
            validator: (value) => validatePassword(value),
          ),
        if (!isEditingProfile)
          SizedBox(
            height: 3.h,
          ),
        if (!isEditingProfile)
          AppInputField(
            controller: confirmPasswordController,
            label: 'Repeat password',
            hint: '••••••••••',
            obscureText: true,
            validator: (value) =>
                validateConfirmPassword(passwordController.text, value),
          ),
        SizedBox(
          height: 3.h,
        ),
        if (isEditingProfile)
          AppButtonPrimary(
              onPressed: () {
                submitForm(context);
              },
              text: 'Update'),
        if (!isEditingProfile) ...[
          BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              return state.maybeWhen(
                  loading: () => const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.nauticalCreatures,
                          ),
                        ],
                      ),
                  orElse: () => AppButtonPrimary(
                      onPressed: () {
                        submitForm(context);
                      },
                      text: 'Sign up'));
            },
          ),
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
        ],
        SizedBox(
          height: 3.h,
        ),
      ]),
    );
  }

  Future<void> showModal() {
    return showAppDialog(
        context: context,
        title: 'Congratulations!',
        description:
            'Your account is ready to use. You will be redirected to the Home poge in a few seconds.',
        buttonLabel: 'Back to Sign in');
  }

  void submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (!isEditingProfile) {
        debugPrint('Signup Screen: Submit Form ===> Form is valid');
        context.read<SignupBloc>().add(
              SignupEvent.signup(
                SignupForm(
                  firstName: firstNameController.text,
                  middleName: middleNameController.text,
                  sirName: lastNameController.text,
                  email: emailController.text,
                  phoneNumber: phoneController.text,
                  gender: gender,
                  region: region,
                  password: passwordController.text,
                ),
              ),
            );
      } else {
        // TODO: implement update profile
      }
    } else {
      debugPrint('Form is invalid');
    }
  }
}
