import 'package:flutter/material.dart';
import 'package:mycricplay/profile/ProfileController.dart';
import 'package:mycricplay/profile/profile_model.dart';

class ProfileUIControllers {
  UserProfileModel userProfileModel;

  ProfileUIControllers({required this.userProfileModel});
  TextEditingController firstNameController = TextEditingController();

  void setDataToModel() {
    userProfileModel.firstName = firstNameController.value.text;
  }
}
