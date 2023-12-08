import 'dart:io';

import 'package:dalali_hub/app/core/widgets/button.dart';
import 'package:dalali_hub/app/utils/colors.dart';
import 'package:dalali_hub/app/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MultiImagePicker extends StatefulWidget {
  final Widget child;
  final List<String> selectedImages;
  final List<String> oldSelectedImages;
  String? activity;

  MultiImagePicker(
      {super.key,
      required this.child,
      required this.selectedImages,
      required this.oldSelectedImages,
      this.activity});

  @override
  State<MultiImagePicker> createState() => _MultiImagePickerState();
}

class _MultiImagePickerState extends State<MultiImagePicker> {
  final ImagePicker picker = ImagePicker();
  void onSelectImage(XFile photo) {
    widget.selectedImages.add(photo.path);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              debugPrint(
                  "Selected Images length ${widget.selectedImages.length}");
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showBottomSheetContent(setState),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: AppButtonPrimary(
                      text: "Save",
                      onPressed: () {
                        if (widget.activity == "Update") {
                          // TODO: call save images BLOC for update activity

                        } else {
                        Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      child: widget.child,
    );
  }

  Widget showBottomSheetContent(StateSetter setState) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 500,
        color: Colors.white,
        child: GridView.builder(
          itemCount: widget.selectedImages.length +
              1 +
              widget.oldSelectedImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) => index < widget.selectedImages.length
              ? Stack(
                  children: [
                    Container(
                      height: 30.w,
                      width: 30.w,
                      padding: const EdgeInsets.all(8.0),
                      child: index < widget.oldSelectedImages.length
                          ? Image.network(widget.oldSelectedImages[index])
                          : Image.file(
                              File(widget.selectedImages[
                                  index - widget.oldSelectedImages.length]),
                              fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (index < widget.oldSelectedImages.length) {
                            // TODO: call remove from old images BLOC
                            
                            widget.oldSelectedImages.removeAt(index);
                          } else {
                            widget.selectedImages.removeAt(
                                index - widget.oldSelectedImages.length);
                          }
                          setState(
                            () {
                              widget.selectedImages.removeAt(index);
                            },
                          );
                        },
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                              color: AppColors.doctor,
                              borderRadius: BorderRadius.circular(4.w)),
                          child: Icon(
                            Icons.remove,
                            size: 4.w,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : addImage(
                  () async {
                    if (widget.selectedImages.length < 5) {
                      await pickMultiImages(picker, onSelectImage);
                      setState(() {});
                    }
                  },
                ),
        ),
      ),
    );
  }

  Widget addImage(var onTap) {
    return GestureDetector(
      onTap: () => widget.selectedImages.length < 5 ? onTap() : null,
      child: Container(
        height: 10.w,
        width: 0.w,
        decoration: const BoxDecoration(
            color: AppColors.doctor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Icon(
            Icons.add,
            size: 10.w,
          ),
        ),
      ),
    );
  }
}
