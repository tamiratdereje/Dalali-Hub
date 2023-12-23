import 'dart:io';

import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class SingelImagePicker extends StatefulWidget {
  final Widget child;
  String? activity;
  String? selectedImage;

  SingelImagePicker(
      {super.key, required this.child, this.selectedImage, this.activity});

  @override
  State<SingelImagePicker> createState() => _SingelImagePickerState();
}

class _SingelImagePickerState extends State<SingelImagePicker> {
  final ImagePicker picker = ImagePicker();
  void onSelectImage(XFile photo) {
    widget.selectedImage = photo.path;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickMultiImages(picker, onSelectImage);
      },
      child: widget.child,
    );
  }


}
