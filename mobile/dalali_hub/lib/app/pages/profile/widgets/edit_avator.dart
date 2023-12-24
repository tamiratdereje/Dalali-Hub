import 'dart:io';

import 'package:dalali_hub/app/widgets/multi_image_picker.dart';
import 'package:dalali_hub/app/widgets/single_image_picker.dart';
import 'package:dalali_hub/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({
    super.key,
    required this.onImageChanged,
    this.image,
    this.imageUrl,
  });

  final File? image;
  final String? imageUrl;
  final Function onImageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 18.w,
          height: 9.8.h,
          margin: EdgeInsets.only(right: 2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Center(
              child: image != null
                  ? Image.file(
                      image!,
                      fit: BoxFit.cover,
                      width: 18.w,
                      height: 9.8.h,
                    )
                  : (imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          width: 18.w,
                          height: 9.8.h,
                        )
                      : Image.network(
                          "https://fastly.picsum.photos/id/815/536/354.jpg?hmac=dbfZclkubuXvBDya7n__oMge7ICuKGU12WSiBbggijI",
                          fit: BoxFit.cover,
                          width: 18.w,
                          height: 9.8.h,
                        )),
            ),
          ),
        ),
        Positioned(
          bottom: 0.5.h,
          right: 0,
          child: SingelImagePicker(
            selectedImage: image != null ?  image!.path : null,
            child: Center(
              child: SvgPicture.asset(
                ImageConstants.profileImageEditor,
                width: 35,
              ),
            ),
            onSelectImage: (XFile? image) {
              onImageChanged(image);
            },
          ),
        )
      ],
    );
  }
}
