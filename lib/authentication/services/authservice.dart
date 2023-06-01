import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mycricplay/general/screens/snackbarcustom.dart';
import 'package:mycricplay/profile/model/ProfileModel.dart';

class AuthService {
  Future<bool> createUserWithEmailAndPassword(
      String emailAddress, String password) async {
    bool isAuthSuccess = false;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await updateUserProfile(credential);
      isAuthSuccess = true;
    } on FirebaseAuthException catch (e) {
      SnackBarCustom.showInfo('Error', e.message.toString());
    } catch (e) {
      SnackBarCustom.showInfo('Error', e.toString());
    }
    return isAuthSuccess;
  }

  Future<bool> signInUserWithEmailAndPassword(
      String emailAddress, String password) async {
    bool isAuthSuccess = false;
    late UserCredential userCredentials;
    try {
      userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      isAuthSuccess = true;


    } on FirebaseAuthException catch (e) {
      SnackBarCustom.showInfo('Error', e.message.toString());
    }
    return isAuthSuccess;
  }

  Future<bool> signOutUser() async {
    var isSuccess = false;
    try {
      await FirebaseAuth.instance.signOut();
      isSuccess = true;
    } catch (e) {
      SnackBarCustom.showInfo('Error', e.toString());
    }
    return isSuccess;
  }

  Future<bool> updateUserProfile(UserCredential userCredential) async {
    User user = userCredential.user!;
    ProfileModel profileModel;
    bool isSuccess = false;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user

    profileModel = ProfileModel(
        uid: user.uid,
        firstName: '',
        lastName: '',
        mobileNumber: '',
        emergencyContact: '',
        gender: '',
        address: '',
        personnelNumber: '',
        dateOfBirth: '',
        email: user.email!,
        imageUrl: '');

    await users.doc(user.uid).set(profileModel.toJson()).then((value) {
      isSuccess = true;

      SnackBarCustom.showInfo("Info", 'User registered successfully');
    }).catchError((error) {
      SnackBarCustom.showInfo('Error', 'Issue in user registration');
    });

    return isSuccess;
  }
}
