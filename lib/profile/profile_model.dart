import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mycricplay/profile/profile_ui_controllers.dart';

class UserProfileModel {
  String uid;
  String firstName;
  String lastName;
  String mobileNumber;
  String emergencyContact;
  String gender;
  String address;
  String personnelNumber;
  String dateOfBirth;
  String email;
  String imageUrl;

  late ProfileUIControllers profileUIControllers;

  static userProfileModelNewObj() {
    return UserProfileModel(
        uid: '',
        firstName: '',
        lastName: '',
        mobileNumber: '',
        emergencyContact: '',
        gender: '',
        address: '',
        personnelNumber: '',
        dateOfBirth: '',
        email: '',
        imageUrl: '');
  }

  UserProfileModel(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.emergencyContact,
      required this.gender,
      required this.address,
      required this.personnelNumber,
      required this.dateOfBirth,
      required this.email,
      required this.imageUrl});

  UserProfileModel.fromJson(Map<String, Object?> json)
      : this(
          uid: json['uid'] as String,
          firstName: json['firstName'] as String,
          lastName: json['lastName'] as String,
          mobileNumber: json['mobileNumber'] as String,
          emergencyContact: json['emergencyContact'] as String,
          gender: json['gender'] as String,
          address: json['address'] as String,
          personnelNumber: json['personnelNumber'] as String,
          dateOfBirth: json['dateOfBirth'] as String,
          email: json['email'] as String,
          imageUrl: json['imageUrl'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'emergencyContact': emergencyContact,
      'gender': gender,
      'address': address,
      'personnelNumber': personnelNumber,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'imageUrl': imageUrl
    };
  }

  Future<void> saveData() {
    User _loginUser;
    FirebaseAuth auth = FirebaseAuth.instance;
    _loginUser = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user

    print(toJson());
    return users
        .doc(_loginUser.uid)
        .set(toJson())
        .then((value) => print("Profile updated"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateImageUrl() {
    User _loginUser;
    FirebaseAuth auth = FirebaseAuth.instance;
    _loginUser = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user

    Map<String, String> imageUrlMap = {'imageUrl': imageUrl};
    return users
        .doc(_loginUser.uid)
        .update(imageUrlMap)
        .then((value) => print("Profile updated"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Stream<QuerySnapshot> readAllUsers() {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    print(dataStream);
    return dataStream;
  }

  static Future<DocumentSnapshot> readCurUserSnapShot() {
    final Future<DocumentSnapshot> dataFuture = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    return dataFuture;
  }

  Future<void> readData() async {
    User _loginUser;
    FirebaseAuth auth = FirebaseAuth.instance;
    _loginUser = FirebaseAuth.instance.currentUser!;
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(_loginUser.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      firstName = data?['firstName'];
      uid = data?['uid'];
      lastName = data?['lastName'];
      mobileNumber = data?['mobileNumber'];
      emergencyContact = data?['emergencyContact'];
      personnelNumber = data?['personnelNumber'];
      email = data?['email'];
      address = data?['address'];
      dateOfBirth = data?['dateOfBirth'];
      gender = data?['gender'];
      // Call setState if needed.

    }
  }
}
