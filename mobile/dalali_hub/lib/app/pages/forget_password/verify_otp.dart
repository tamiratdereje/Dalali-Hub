import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/forget_password/bloc/request_bloc/request_otp_bloc.dart';
import 'package:dalali_hub/app/pages/forget_password/bloc/verify_otp/verify_otp_bloc.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/domain/entity/verify_otp.dart';
import 'package:dalali_hub/domain/type/types.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

typedef ResendOtp = VerifyOtp;

class VerifyOTP extends StatefulWidget {
  final String? email;
  final String? phone;
  final OtpPurpose otpPurpose;
  final OtpType otpType;

  const VerifyOTP(
      {super.key,
      this.email,
      this.phone,
      required this.otpPurpose,
      required this.otpType});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  String? otp;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerifyOtpBloc>(
          create: (context) => getIt<VerifyOtpBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<RequestOtpBloc>(),
        ),
      ],
      child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
        listener: (context, state) {
          state.mapOrNull(
            verified: (_) {
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  showSuccessSnackBar('Otp verified successfully', context));
              if (widget.otpPurpose == OtpPurpose.RESET_PASSWORD) {
                context.go(
                  AppRoutes.createNewPassword,
                  extra: {
                    'email': widget.email,
                    'phone': widget.phone,
                  },);
              } else {
                context.pop();
              }
            },
            error: (error) => WidgetsBinding.instance.addPostFrameCallback(
              (_) => showErrorSnackBar(error.message, context),
            ),
          );
        },
        builder: (context, state) {
          return BlocConsumer<RequestOtpBloc, RequestOtpState>(
            listener: (context, requestOtpState) {
              requestOtpState.mapOrNull(
                sent: (_) => showSuccessSnackBar(
                    'Otp sent successfully to ${widget.email ?? widget.phone}',
                    context),
                error: (error) => WidgetsBinding.instance.addPostFrameCallback(
                  (_) => showErrorSnackBar(error.message, context),
                ),
              );
            },
            builder: (context, requestOtpState) {
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(8.h),
                  child: DalaliAppBar(
                    leadingButtonAction: () => context.pop(),
                    titleWidget: Text(
                      'Code Confirmation',
                      style: titleFont,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(4.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          "The Code has been sent to",
                          textAlign: TextAlign.center,
                          style: inputFieldHintStyle.copyWith(fontSize: 16.sp),
                        ),
                        Text(
                          widget.email ?? widget.phone!,
                          textAlign: TextAlign.center,
                          style:
                              inputFieldLabelMinStyle.copyWith(fontSize: 16.sp),
                        ),
                        SizedBox(height: 4.h),
                        OtpTextField(
                          handleControllers: (controllers) => {},
                          fillColor: AppColors.ultimateGray.withOpacity(0.2),
                          textStyle: bodyTextStyle.copyWith(
                              color: AppColors.optTextColor),
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
                          focusedBorderColor:
                              Theme.of(context).colorScheme.primary,
                          onSubmit: (value) {
                            setState(() {
                              otp = value;
                            });
                          },
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive the code?",
                              textAlign: TextAlign.center,
                              style: buttonContainerBoldStyle.copyWith(
                                  color: AppColors.minBodyTextColor,
                                  fontSize: 16.sp),
                            ),
                            BlocBuilder<RequestOtpBloc, RequestOtpState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  loading: () => const SizedBox.shrink(),
                                  orElse: () => TextButton(
                                    child: Text(
                                      "Resend Code",
                                      textAlign: TextAlign.center,
                                      style: buttonContainerBoldStyle.copyWith(
                                          color: AppColors.successColor,
                                          fontSize: 16.sp),
                                    ),
                                    onPressed: () => resendOtp(context),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 14.1.h),
                        requestOtpState.maybeWhen(
                          loading: () => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.nauticalCreatures,
                            ),
                          ),
                          orElse: () => state.maybeWhen(
                            loading: () => const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.nauticalCreatures,
                            )),
                            orElse: () => AppButtonPrimary(
                              text: "Confirm code",
                              onPressed: () => verify(otp!, context),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void verify(String otp, BuildContext context) {
    var otpType = widget.email != null ? OtpType.EMAIL : OtpType.PHONE;
    context.read<VerifyOtpBloc>().add(
          VerifyOtpEvent.verify(
            VerifyOtp(
              otp: otp,
              phoneNumber: widget.phone,
              email: widget.email,
              otpType: otpType,
              purpose: widget.otpPurpose,
            ),
          ),
        );
  }

  void resendOtp(BuildContext context) {
    var otpType = widget.email != null ? OtpType.EMAIL : OtpType.PHONE;
    context.read<RequestOtpBloc>().add(
          RequestOtpEvent.requestOtp(
            ResendOtp(
              phoneNumber: widget.phone,
              email: widget.email,
              otpType: otpType,
              purpose: widget.otpPurpose,
            ),
          ),
        );
  }
}
