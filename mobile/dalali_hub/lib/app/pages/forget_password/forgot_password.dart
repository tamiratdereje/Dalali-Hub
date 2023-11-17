import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/pages/forget_password/widgets/forgot_password_appbar.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isSms = false;
  bool isEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ForgotPasswordAppBar(
        title: "Forgotten Password",
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
              tap: () {
                setState(() {
                  isSms = true;
                  isEmail = false;
                });
              },
              isSms: isSms,
              isEmail: isEmail,
              color: isSms ? AppColors.selectedContainer : AppColors.white ,
            ),
            const SizedBox(
              height: 15,
            ),
            EmailOrSMSButton(
              title: "Through email",
              detail: "mkumbwa.kessy@gmail.com",
              icon: ImageConstants.email,
              tap: () {
                setState(() {
                  isEmail = true;
                  isSms = false;
                });
              },
              isSms: isSms,
              isEmail: isEmail,
              color:  isEmail ? AppColors.selectedContainer : AppColors.white ,
            ),
            SizedBox(
              height: 7.8.h,
            ),
            AppButtonPrimary(
              text: "Send code",
              onPressed: () {},
            ),
          ],
        )),
      ),
    );
  }
}

class EmailOrSMSButton extends StatelessWidget {
  String icon;
  String title;
  String detail;
  Function tap;
  bool isSms;
  bool isEmail;
  Color color;
  EmailOrSMSButton(
      {super.key,
      required this.title,
      required this.detail,
      required this.icon,
      required this.tap,
      this.isSms = false,
      this.isEmail = false,
      this.color = AppColors.white});

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
              // spreadRadius: 13,
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
                  style: buttonContainerWatermarkStyle,
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
        tap();
      },
    );
  }
}
