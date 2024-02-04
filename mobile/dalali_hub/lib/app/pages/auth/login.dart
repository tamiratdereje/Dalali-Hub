import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:dalali_hub/domain/entity/login.dart';
import 'package:dalali_hub/domain/type/types.dart';
import 'package:dalali_hub/domain/validators/validators.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        body: SingleChildScrollView(
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
                'Login to your account',
                style: titleFont,
              ),
              SizedBox(
                height: 3.h,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) =>
                          showSuccessSnackBar(
                              'Logged in successfully', context));
                      context.go(AppRoutes.home);
                    },
                    error: (message) =>
                        WidgetsBinding.instance.addPostFrameCallback(
                      (_) => showErrorSnackBar(message, context),
                    ),
                    unVerified: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) =>
                          showErrorSnackBar(
                              'Please verify your email address', context));
                      context.push(AppRoutes.otp, extra: {
                        'email': emailController.text,
                        'otpPurpose': OtpPurpose.VERIFICATION,
                        'phone': null,
                        'otpType': OtpType.EMAIL
                      });
                    },
                  );
                },
                builder: (context, state) {
                  return loginForm();
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () => context.push(AppRoutes.forgotPassword),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have you forgotten your password?",
                        style: linkTextStylePrimary),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Form loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppInputField(
            controller: emailController,
            label: 'Email address',
            hint: 'hello@gmail.com',
            keyboardType: TextInputType.emailAddress,
            validator: (value) => validateEmail(value),
          ),
          SizedBox(
            height: 1.h,
          ),
          AppInputField(
            controller: passwordController,
            label: 'Password',
            hint: '••••••••••',
            obscureText: true,
            validator: (value) => validatePassword(value),
          ),
          SizedBox(
            height: 1.h,
          ),
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return state.maybeMap(
                loading: (_) => const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.nauticalCreatures,
                    )),
                orElse: () => AppButtonPrimary(
                      onPressed: () => submitForm(context),
                      text: 'Sign in',
                    ));
          }),
          SizedBox(
            height: 2.h,
          ),

          // socialMediaAuth(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: bodyTextStyle,
              ),
              GestureDetector(
                onTap: () => context.push(AppRoutes.register,
                    extra: {"isEditingProfile": false}),
                child: Text(
                  'Click here',
                  style: linkTextStylePrimary,
                ),
              ),
            ],
          )
        ],
      ),
    );
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

  void submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(LoginEvent.login(
          login: Login(
              email: emailController.text, password: passwordController.text)));
    }
  }
}
