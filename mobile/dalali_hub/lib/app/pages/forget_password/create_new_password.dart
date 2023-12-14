import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/input_field.dart';
import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/forget_password/bloc/reset_password/reset_password_bloc_bloc.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:dalali_hub/domain/entity/reset_password.dart';
import 'package:dalali_hub/domain/validators/validators.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
    return BlocProvider<ResetPasswordBloc>(
      create: (context) => getIt<ResetPasswordBloc>(),
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          state.mapOrNull(
            success: (_) {
              context.go(AppRoutes.login);
            },
            error: (error) => WidgetsBinding.instance.addPostFrameCallback(
              (_) => showErrorSnackBar(error.message, context),
            ),
            tokenExpired: (_) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => showErrorSnackBar('Your token has expired please verify your email again!', context),
              );
              context.go(AppRoutes.forgotPassword);
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(8.h),
              child: DalaliAppBar(
                leadingButtonAction: () => context.go(AppRoutes.login),
                titleWidget: Text(
                  'Create a new Password',
                  style: titleFont,
                ),
              ),
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
                            validator: (value) => validatePassword(value),
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          AppInputField(
                              controller: repeatPasswordController,
                              label: 'Repeat new password',
                              hint: '*******',
                              obscureText: true,
                              validator: (value) => validateConfirmPassword(
                                  value, newPasswordController.text)),
                          SizedBox(
                            height: 3.4.h,
                          ),
                          state.maybeMap(
                            loading: (value) => const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.nauticalCreatures,
                            )),
                            orElse: () => AppButtonPrimary(
                              text: "Continue",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<ResetPasswordBloc>().add(
                                      ResetPasswordEvent.resetPassword(
                                          ResetPassword(
                                              newPassword:
                                                  newPasswordController.text)));
                                }
                              },
                            ),
                          )
                        ],
                      )),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
