import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/forget_password/bloc/request_bloc/request_otp_bloc.dart';
import 'package:dalali_hub/app/pages/forget_password/widgets/take_email_or_phone.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:dalali_hub/domain/entity/verify_otp.dart';
import 'package:dalali_hub/domain/type/types.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

typedef ResendOtp = VerifyOtp;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isSms = false;
  bool isEmail = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  OtpType? selectedOtpType;

  String? email;
  String? phone;

  void setEmail() {
    setState(() {
      email = emailController.text;
    });
  }

  void setPhone() {
    setState(() {
      phone = phoneController.text;
    });
  }

  void setSelectedType(OtpType otpType) {
    selectedOtpType = otpType;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestOtpBloc>(
      create: (context) => getIt<RequestOtpBloc>(),
      child: BlocConsumer<RequestOtpBloc, RequestOtpState>(
        listener: (context, state) {
          state.mapOrNull(
            sent: (value) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => showSuccessSnackBar(
                    'Otp is sent to ${email ?? phone} successfully', context),
              );
              context.push(
                AppRoutes.otp,
                extra: {
                  'email': email,
                  'otpPurpose': OtpPurpose.RESET_PASSWORD,
                  'phone': phone,
                  'otpType': selectedOtpType
                },
              );
            },
            error: (error) => WidgetsBinding.instance.addPostFrameCallback(
              (_) => showErrorSnackBar(error.message, context),
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(8.h),
              child: DalaliAppBar(
                leadingButtonAction: () => context.pop(),
                titleWidget: Text(
                  'Forgot Password',
                  style: titleFont,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                  left: 6.6.w, right: 6.6.w, top: 5.1.h, bottom: 5.6.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ImageConstants.forgotPasswordIllu,
                    ),
                    SizedBox(
                      height: 3.2.h,
                    ),
                    Text(
                      "How are you going to receive your code?",
                      style: inputFieldHintStyle,
                    ),
                    SizedBox(
                      height: 2.3.h,
                    ),
                    EmailOrSMSButton(
                      title: "Through an sms",
                      detail: "+255 65* *** ***",
                      icon: ImageConstants.sms,
                      otpType: OtpType.PHONE,
                      textController: phoneController,
                      formKey: formKey,
                      onSave: setPhone,
                      onTap: () {
                        setState(() {
                          isSms = true;
                          isEmail = false;
                          setSelectedType(OtpType.PHONE);
                        });
                      },
                      isSms: isSms,
                      isEmail: isEmail,
                      color:
                          isSms ? AppColors.selectedContainer : AppColors.white,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    EmailOrSMSButton(
                      title: "Through email",
                      detail: "mkumbwa.kessy@gmail.com",
                      icon: ImageConstants.email,
                      otpType: OtpType.EMAIL,
                      textController: emailController,
                      formKey: formKey,
                      onSave: setEmail,
                      onTap: () {
                        setState(() {
                          isEmail = true;
                          isSms = false;
                          setSelectedType(OtpType.EMAIL);
                        });
                      },
                      isSms: isSms,
                      isEmail: isEmail,
                      color: isEmail
                          ? AppColors.selectedContainer
                          : AppColors.white,
                    ),
                    SizedBox(
                      height: 7.8.h,
                    ),
                    state.maybeWhen(
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.nauticalCreatures,
                        ),
                      ),
                      orElse: () => AppButtonPrimary(
                        text: "Send code",
                        onPressed: () {
                          debugPrint("selected otp type $selectedOtpType");
                          if (selectedOtpType == null) {
                            showErrorSnackBar(
                                'Choose how you are going to recieve your code',
                                context);
                            return;
                          }
                          context.read<RequestOtpBloc>().add(
                                RequestOtpEvent.requestOtp(
                                  ResendOtp(
                                    phoneNumber: phone,
                                    email: email,
                                    otpType: selectedOtpType!,
                                    purpose: OtpPurpose.RESET_PASSWORD,
                                  ),
                                ),
                              );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EmailOrSMSButton extends StatelessWidget {
  final String icon;
  final String title;
  final String detail;
  final Function onTap;
  final Function onSave;
  final OtpType otpType;
  final TextEditingController textController;
  final GlobalKey<FormState> formKey;
  bool isSms;
  bool isEmail;
  Color color;

  EmailOrSMSButton(
      {super.key,
      required this.title,
      required this.detail,
      required this.icon,
      required this.onTap,
      required this.otpType,
      this.isSms = false,
      this.isEmail = false,
      this.color = AppColors.white,
      required this.textController,
      required this.formKey,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              blurRadius: 13,
              offset: Offset(3, 3), // changes position of shadow
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.avatorBackground,
              radius: 6.2.w,
              child: SvgPicture.asset(icon),
            ),
            SizedBox(
              width: 4.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: inputFieldLabelStyle,
                ),
                Text(
                  detail,
                  style: buttonContainerBoldStyle,
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
        showEmailOrPhoneForm(
            context: context,
            otpType: otpType,
            textController: textController,
            formKey: formKey,
            onSave: () => onSave());
      },
    );
  }
}
