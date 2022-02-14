import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<File?> pickFile({
    required bool fromGallery,
    Future<File?> Function(File file)? cropImage,
  }) async {
    final source = fromGallery ? ImageSource.gallery : ImageSource.camera;
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return null;

    if (cropImage == null) {
      return File(pickedFile.path);
    } else {
      final file = File(pickedFile.path);

      return cropImage(file);
    }
  }
}
