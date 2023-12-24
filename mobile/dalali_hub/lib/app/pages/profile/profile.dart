import 'dart:io';

import 'package:dalali_hub/app/core/widgets/alert_dialog.dart';
import 'package:dalali_hub/app/core/widgets/appbar.dart';
import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/core/widgets/snackbar.dart';
import 'package:dalali_hub/app/core/widgets/yes_or_no_dialog.dart';
import 'package:dalali_hub/app/navigation/routes.dart';
import 'package:dalali_hub/app/pages/customer_home/widgets/customer_appbar.dart';
import 'package:dalali_hub/app/pages/profile/bloc/profile/profile_bloc.dart';
import 'package:dalali_hub/app/pages/profile/bloc/update_profile_photo/update_profile_photo_bloc.dart';
import 'package:dalali_hub/app/pages/profile/widgets/edit_avator.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/font_style.dart';
import 'package:dalali_hub/domain/entity/user.dart';
import 'package:dalali_hub/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("profile called");
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => getIt.get<ProfileBloc>()
            ..add(
              const ProfileEvent.profile(),
            ),
        ),
        BlocProvider(
          create: (context) => getIt.get<UpdateProfilePhotoBloc>(),
        )
      ],
      child: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? selectedImage;
  XFile? selectedXFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(8.h),
          child: DalaliAppBar(
            leadingButtonAction: () => {},
            titleWidget: Text(
              'My profile',
              style: titleFont,
            ),
            onTapTrailingButton: (value) async {
              debugPrint("popup menu item $value");
              if (value.trim() == "Edit") {
                debugPrint("popup again  $value");
                User userData = await context.push(AppRoutes.register, extra: {
                  "isEditingProfile": true,
                }) as User;
                debugPrint(
                    "user datahhhhhhhhhhhhhhhhhhhhhhhhhhhh from editing ${userData.firstName} ");

                // ignore: use_build_context_synchronously
                context
                    .read<ProfileBloc>()
                    .add(ProfileEvent.updateProfile(userData));
              }
            },
            trailingWidget: Container(
              width: 10.6.w,
              height: 4.6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.ultimateGray, width: .3.w),
              ),
              child: const Center(
                child: Icon(Icons.more_vert, color: AppColors.black),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 6.6.w,
            right: 6.6.w,
            bottom: 5.6.h,
          ),
          child: SingleChildScrollView(
            child: BlocConsumer<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return state.maybeMap(
                    orElse: () => Container(),
                    initial: (value) => Container(),
                    loading: (value) =>
                        const Center(child: CircularProgressIndicator()),
                    success: (data) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 3.7.h,
                          ),
                          EditAvatar(
                            imageUrl: selectedImage != null
                                ? selectedImage!.path
                                : (data.userResponse.photos.isNotEmpty
                                    ? data.userResponse.photos[0].secoureUrl
                                    : "https://fastly.picsum.photos/id/815/536/354.jpg?hmac=dbfZclkubuXvBDya7n__oMge7ICuKGU12WSiBbggijI"),
                            onImageChanged: (XFile? image) async {
                              setState(() {
                                debugPrint("Image changed");
                                selectedXFile = image;
                                selectedImage =
                                    image != null ? File(image.path) : null;
                              });
                              String? decision = await showYesOrNoDialog(
                                  context: context,
                                  title: 'Profile picture!',
                                  description:
                                      'Do you want to make this ugly photo you profile picture?',
                                  image: selectedImage!.path,
                                  onButtonPressed: () {});
                              if (decision == "Yes") {
                                debugPrint(decision);
                                // ignore: use_build_context_synchronously
                                BlocProvider.of<UpdateProfilePhotoBloc>(context)
                                    .add(UpdateProfilePhotoEvent
                                        .updateProfilePhoto(
                                            photos: [selectedImage!.path]));
                              } else {
                                setState(() {
                                  selectedImage = null;
                                });
                                debugPrint(decision);
                              }
                            },
                            image: selectedImage,
                          ),
                          BlocConsumer<UpdateProfilePhotoBloc,
                              UpdateProfilePhotoState>(
                            builder: (context, state) {
                              return Container();
                            },
                            listener: ((context, state) => state.maybeMap(
                                orElse: () => {},
                                loading: (value) {},
                                success: (value) {
                                  debugPrint(
                                      "success updating the profile picture");
                                  context.read<ProfileBloc>().add(
                                      ProfileEvent.updateProfilePicture(
                                          value.photos));
                                  setState(() {
                                    selectedImage = null;
                                  });
                                  return WidgetsBinding.instance
                                      .addPostFrameCallback((_) =>
                                          showSuccessSnackBar(
                                              'Profile picture successfully updated.',
                                              context));
                                },
                                error: (value) {
                                  setState(() {
                                    selectedImage = null;
                                  });
                                  return WidgetsBinding.instance
                                      .addPostFrameCallback((_) =>
                                          showErrorSnackBar(
                                              'Can not updated profile pickture due to network.',
                                              context));
                                  ;
                                })),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "${data.userResponse.firstName} ${data.userResponse.middleName[0]}. ${data.userResponse.sirName}",
                            style: bodyTextStyle.copyWith(
                                color: AppColors.profileNameColor,
                                fontSize: 20.sp),
                          ),
                          SizedBox(
                            height: 3.7.h,
                          ),
                          profileDataWidget("Date Of Birth:", "16 Jan 2000"),
                          SizedBox(
                            height: 1.3.h,
                          ),
                          profileDataWidget(
                              "Gender:", data.userResponse.gender),
                          SizedBox(
                            height: 1.3.h,
                          ),
                          profileDataWidget("Email:", data.userResponse.email),
                          SizedBox(
                            height: 1.3.h,
                          ),
                          profileDataWidget(
                              "Phone:", data.userResponse.phoneNumber),
                          SizedBox(
                            height: 1.3.h,
                          ),
                          profileDataWidget("Region:", "Oromia"),
                        ]),
                  );
                },
                listener: (state, context) {}),
          ),
        ));
  }

  Container profileDataWidget(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.doctor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: double.infinity,
      height: 4.1.h,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: bodyTextStyle.copyWith(
              color: AppColors.nauticalCreatures,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
        ),
        Text(value,
            style: bodyTextStyle.copyWith(
                color: AppColors.nauticalCreatures,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400)),
      ]),
    );
  }
}
