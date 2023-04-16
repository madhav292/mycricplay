import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycricplay/profile/model/ProfileModel.dart';

class ProfileController extends GetxController {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  var isLoading = true.obs;
  late TextEditingController firstNameController, lastNameController;
  late TextEditingController addressController, mobileNumberController,emergencyContactController;
  late TextEditingController personnelNumberController, dateOfBirthController;
  late TextEditingController emailController,genderController;

  var firstName = '';
  var lastName = '';

  var profileList = [];
  late ProfileModel profileModel;
  late List<ProfileModel> profileModelList = [];

  Future<ProfileModel> getCurrentUser() async {
    DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    Map<String, dynamic> data = docSnapShot.data() as Map<String, dynamic>;

    profileModel = ProfileModel.fromJson(data);

    return profileModel;
  }

  Future<List<ProfileModel>> getUsersList() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        Map<String, dynamic> data = result.data() as Map<String, dynamic>;

        profileModelList.add(ProfileModel.fromJson(data));
      }
    });

    return profileModelList;
  }

  Future<void> saveDataFirebase() {
    User loginUser;
    FirebaseAuth auth = FirebaseAuth.instance;
    loginUser = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user

print(profileModel.toJson());
    return users
        .doc(loginUser.uid)
        .set(profileModel.toJson())
        .then((value) => print("Profile updated"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void saveData() {
    if (profileFormKey.currentState!.validate()) {
      setDataToModel();
      saveDataFirebase();
    }
  }

  void setDataToModel() {
    print(profileModel.firstName);
    profileModel.firstName = firstNameController.value.text;
    profileModel.lastName = lastNameController.value.text;
    profileModel.dateOfBirth = dateOfBirthController.value.text;
    profileModel.address = addressController.value.text;
    profileModel.mobileNumber = mobileNumberController.value.text;
    profileModel.emergencyContact = emergencyContactController.value.text;
    profileModel.email = emailController.value.text;
    profileModel.personnelNumber = personnelNumberController.value.text;
  }

  @override
  Future<void> onInit() async {

    print('init meethod');
    super.onInit();
    await getCurrentUser();
    setDataToControls();

  }
  void setDataToControls()
  {
    firstNameController = TextEditingController(text: profileModel.firstName);
    lastNameController = TextEditingController(text: profileModel.lastName);
    dateOfBirthController = TextEditingController(text:profileModel.dateOfBirth);
    addressController = TextEditingController(text:profileModel.address);
    mobileNumberController = TextEditingController(text: profileModel.mobileNumber);
    emergencyContactController = TextEditingController(text: profileModel.emergencyContact);
    emailController = TextEditingController(text: profileModel.email);
    personnelNumberController =TextEditingController(text: profileModel.personnelNumber);
    //genderController = TextEditingController(text: )



  }

  @override
  void onClose() {
    print('dispose method');

    super.onClose();
  }
}
