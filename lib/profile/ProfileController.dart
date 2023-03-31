import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycricplay/profile/profile_model.dart';
import 'package:mycricplay/profile/profile_ui_controllers.dart';

class ProfileController extends GetxController {
  TextEditingController firstNameController = TextEditingController();

  List<UserProfileModel> _userProfileModel = [];
  UserProfileModel curUserProfileModel =
      UserProfileModel.userProfileModelNewObj();

  Future<UserProfileModel> getCurrentUser() async {
    DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    Map<String, dynamic> data = docSnapShot.data() as Map<String, dynamic>;

    curUserProfileModel = UserProfileModel.fromJson(data);

    return curUserProfileModel;
  }

  Future<List<UserProfileModel>> getUsersList() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        Map<String, dynamic> data = result.data() as Map<String, dynamic>;
        _userProfileModel.add(UserProfileModel.fromJson(data));
      }
    });

    return _userProfileModel;
  }

  void saveData() {
    ProfileUIControllers profileUIControllers =
        ProfileUIControllers(userProfileModel: curUserProfileModel);
    profileUIControllers.setDataToModel();

    curUserProfileModel.saveData();
  }

  void setDataToModel() {
    curUserProfileModel.firstName = firstNameController.text;
    print(curUserProfileModel.firstName);
  }
}
