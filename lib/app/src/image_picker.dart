import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage() async {
  ImagePicker imagePicker = ImagePicker();
  return await imagePicker.pickImage(source: ImageSource.gallery);
}

