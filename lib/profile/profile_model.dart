import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profile_model {
  late String uid = '';
  late String firstName = '';
  late String lastName = '';
  late String mobileNumber = '';
  late String emergencyContact = '';
  late String gender = '';

  profile_model();

  late String address = '';
  late String personnelNumber = '';
  late String dateOfBirth = '';
  late String email = '';

  profile_model.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        mobileNumber = json['mobileNumber'],
        emergencyContact = json['emergencyContact'],
        email = json['email'],
        dateOfBirth = json['dateOfBirth'],
        address = json['address'],
        personnelNumber = json['personnelNumber'],
        uid = json['uid'];

  Future<void> saveData() {
    User _loginUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    _loginUser = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user
    return users
        .doc(_loginUser.uid)
        .set({
          'uid': this.uid,
          'firstName': this.firstName,
          'lastName': this.lastName,
          'mobileNumber': this.mobileNumber,
          'emergencyContact': this.emergencyContact,
          'personnelNumber': this.personnelNumber,
          'address': this.address,
          'dateOfBirth': this.dateOfBirth,
          'email': this.email,
          'gender': this.gender
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Stream<QuerySnapshot> readAllUsers() {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    return dataStream;
  }

  Future<void> readData() async {
    User _loginUser;
    FirebaseAuth auth = FirebaseAuth.instance;
    _loginUser = FirebaseAuth.instance.currentUser!;
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(_loginUser.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      this.firstName = data?['firstName'];
      this.uid = data?['uid'];
      this.lastName = data?['lastName'];
      this.mobileNumber = data?['mobileNumber'];
      this.emergencyContact = data?['emergencyContact'];
      //this.personnelNumber = data?['personnelNumber'];
      this.email = data?['email'];
      this.address = data?['address'];
      this.dateOfBirth = data?['dateOfBirth'];
      this.gender = data?['gender'];
      // Call setState if needed.

    }
  }
}
