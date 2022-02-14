import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';

import 'package:cropper_image_app/src/utils.dart';

///
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cropper'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 100,
                child: ClipOval(
                  child: image == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 100,
                        )
                      : Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onClickedButton,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future onClickedButton() async {
    final file = await Utils.pickFile(
      fromGallery: true,
      cropImage: cropSquareImage,
    );

    if (file == null) return;
    setState(() => image = file);
  }

  Future<File?> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        compressQuality: 70,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: androidUiSettingsLocked(),
        iosUiSettings: iosUiSettingsLocked(),
      );

  IOSUiSettings iosUiSettingsLocked() => const IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => const AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
      );
}
