import 'package:dalali_hub/app/core/widgets/tactile_button.dart';
import 'package:dalali_hub/constants/color_constants.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhoAreYou extends StatelessWidget {
  const WhoAreYou({super.key});

  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SvgPicture.asset(
              ImageConstants.dalaliLogoIllu,
              height: 300,
            ),
            const SizedBox(
              height: 90,
            ),
            const Text(
              "Welcome",
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Who are you?",
            ),
            const SizedBox(
              height: 38,
            ),
            TactileButton(
              text: "Customer",
              alignment: MainAxisAlignment.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                const Text("or"),
                const SizedBox(
                  width: 9,
                ),
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TactileButton(
              text: "Broker/Agent",
              alignment: MainAxisAlignment.center,
            ),
            const SizedBox(
              height: 67,
            ),
            Row(
              children: [
                const Text("You don't have an account?"),
                TextButton(
                  onPressed: () {},
                  child: const Text("Sign up here "),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
