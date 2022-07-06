import 'package:cloud_firestore/cloud_firestore.dart';

class Grounds_model {
  String groundName;
  String address;

  Grounds_model({required this.groundName, required this.address});

  Grounds_model.fromJson(Map<String, Object?> json)
      : this(
          groundName: json['groundName']! as String,
          address: json['address']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'groundName': groundName,
      'address': address,
    };
  }

  static void deleteData(Grounds_model groundModelObj) {
    FirebaseFirestore.instance
        .collection('grounds')
        .doc(groundModelObj.groundName)
        .delete();
  }

  static Stream<QuerySnapshot> readData() {
    final Stream<QuerySnapshot> groundsStream =
        FirebaseFirestore.instance.collection('grounds').snapshots();
    return groundsStream;
  }

  Future<void> saveData() {
    CollectionReference grounds =
        FirebaseFirestore.instance.collection('grounds');
    // Call the user's CollectionReference to add a new user
    return grounds
        .doc(groundName)
        .set({'groundName': groundName, 'address': address})
        .then((value) => print("Ground Added"))
        .catchError((error) => print("Failed to add ground: $error"));
  }

  final groundsList = FirebaseFirestore.instance
      .collection('grounds')
      .withConverter<Grounds_model>(
        fromFirestore: (snapshot, _) =>
            Grounds_model.fromJson(snapshot.data()!),
        toFirestore: (Grounds_model, _) => Grounds_model.toJson(),
      );
}
