import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickMultiImages(
    ImagePicker picker, Function onSelectImages) async {
  final pickedFiles = await picker.pickMultiImage(
      imageQuality: 75, maxHeight: 1000, maxWidth: 1000);
  for (var image in pickedFiles) {
    debugPrint("Image Picker: ${image.path}");
    onSelectImages(image);
  }
}

Future<void> pickSingleImages(
    ImagePicker picker, Function onSelectImages) async {
  final pickedFiles = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
      maxHeight: 1000,
      maxWidth: 1000);
  debugPrint("Image Picker: ${pickedFiles!.path}");
  onSelectImages(pickedFiles);
}
