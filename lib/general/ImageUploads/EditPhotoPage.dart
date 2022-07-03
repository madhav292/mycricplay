
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';


class EditPhotoPage extends StatefulWidget {
  File image;

  EditPhotoPage({required this.image});

  @override
  _EditPhotoPageState createState() => _EditPhotoPageState();
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  File? imageFile;

  @override
  void initState() {
    super.initState();
    imageFile = widget.image;
    if (imageFile != null) _cropImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Hello'));
  }

  Future<Null> _cropImage() async {

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

  }
}
