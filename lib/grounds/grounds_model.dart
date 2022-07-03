import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class grounds_model {
  late String groundName = '';
  late String address = '';

  Future<void> saveData() {
    CollectionReference grounds =
        FirebaseFirestore.instance.collection('grounds');
    // Call the user's CollectionReference to add a new user
    return grounds
        .doc()
        .set({'ground_name': groundName, 'address': address})
        .then((value) => print("Ground Added"))
        .catchError((error) => print("Failed to add ground: $error"));
  }
}
