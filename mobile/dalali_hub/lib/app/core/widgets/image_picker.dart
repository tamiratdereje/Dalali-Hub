
import 'package:image_picker/image_picker.dart';

Future<XFile> pickImageFromGallery(ImagePicker picker, Function onSelect) async {
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image!;
}

Future<XFile> pickImageFromCamera(ImagePicker picker, Function onSelect) async {
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  return image!;
}