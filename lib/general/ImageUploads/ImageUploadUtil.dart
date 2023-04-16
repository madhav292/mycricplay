import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycricplay/general/ImageUploads/AppFeature.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:mycricplay/profile/controller/ProfileController.dart';
import 'package:mycricplay/profile/model/ProfileModel.dart';
import 'package:path/path.dart';

class ImageUploadUtil {
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  String imageUploadPath;
  String fileName;
  bool doImageCrop;
  String imageUrl = '';
  AppFeature appFeature;

  ImageUploadUtil(
      {required this.imageUploadPath,
      required this.doImageCrop,
      required this.appFeature,
      required this.fileName});

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
            toolbarTitle: 'Crop image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop image',
        ),
      ],
    );

    return XFile(croppedFile!.path);
  }

  Future imgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (doImageCrop) {
      pickedFile = await cropImage(pickedFile);
    }
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      imageUrl = await uploadFile();
    }
    return imageUrl;
  }

  Future imgFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (doImageCrop) {
      pickedFile = await cropImage(pickedFile);
    }
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      imageUrl = await uploadFile();
    }
    return imageUrl;
  }

  Future uploadFile() async {
    if (_photo == null) return '';

    final fileName = basename(_photo!.path);
    var destination = imageUploadPath + fileName;

    try {
      File? uploadPhoto;
      FirebaseStorage storage = FirebaseStorage.instance;
print('image upload');
      Reference ref = storage.ref(destination);
      uploadPhoto = File(_photo!.path);
      UploadTask uploadTask = ref.putFile(uploadPhoto);
      await uploadTask.then((res) async {
        imageUrl = await res.ref.getDownloadURL();
        print('image uploaded');
        print(appFeature);
        updateReferenceUrl();
      });
    } catch (e) {
      return 'error';
    }

    return imageUrl;
  }

  Future removeImage(String fileName) async {
    try {
      final ref = FirebaseStorage.instance
          .ref(imageUploadPath)
          .child(fileName)
          .delete();

      imageUrl = '';
      await updateReferenceUrl();
    } catch (e) {
      print('error occured');
    }
  }

  //Update the image url on model class of the the feature
  updateReferenceUrl() {

    if (appFeature == AppFeature.profile) {
      ProfileController controller = Get.find<ProfileController>();
      controller.profileModel.imageUrl = imageUrl;
      controller.profileModel.updateImageUrl();
    } else if (appFeature == AppFeature.grounds) {
      GroundsModel groundsModel = Get.find();
      groundsModel.imageUrl = imageUrl;
      groundsModel.updateImageUrl();
    }
  }

  /* static getImageUrl(context, String imageUploadPath, bool cropImage) async {
    ImageUploadUtil imageUploadUtil = ImageUploadUtil();
    imageUploadUtil.doImageCrop = cropImage;
    imageUploadUtil.imageUploadPath = imageUploadPath;

    imageUploadUtil.showPicker(context);
    print('after picker');
    return imageUploadUtil.imageUrl;
  }*/
}
