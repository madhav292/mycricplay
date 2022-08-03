import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageUploads extends StatefulWidget {
  String imageUrl = '';
  ImageUploads({Key? key, String? imageUrl}) : super(key: key);

  @override
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads> {
  //firebase_storage.FirebaseStorage storage =
  //   firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  var imageUploadUrl;

  Future imgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    pickedFile = await cropImage(pickedFile);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        //uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  cropImage(XFile? _pickedFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile!.path,
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

    return XFile(croppedFile!.path);
  }

  Future removeImage() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    var destination = FirebaseAuth.instance.currentUser?.uid;

    try {
      final ref = FirebaseStorage.instance.ref(destination);
    } catch (e) {
      print('error occured');
    }
    setState(() {
      _photo = null;
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    var destination = FirebaseAuth.instance.currentUser?.uid;

    try {
      final ref =
          FirebaseStorage.instance.ref('ProfileImages/').child('$destination');
      await ref.putFile(_photo!);
      var imageUrlLoc = await ref.getDownloadURL();

      setState(() {
        imageUploadUrl = imageUrlLoc;
      });
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await uploadFile();
                Navigator.pop(context, imageUploadUrl);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 32,
          ),
          /*Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xffFDCF09),
                child: _photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _photo!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),*/
          Center(
            child: GestureDetector(
              onTap: () {
                showPicker(context);
              },
              child: _photo != null
                  ? Image.file(_photo!)
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove photo'),
                  onTap: () {
                    removeImage();

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
