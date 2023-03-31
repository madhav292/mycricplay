import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroundsModel {
  String groundName;
  String address;
  String imageUrl;

  List<GroundsModel> groundsModelList = [];

  GroundsModel(
      {required this.groundName,
      required this.address,
      required this.imageUrl});

  static GroundsModelObj() {
    return GroundsModel(imageUrl: ' ', address: '', groundName: '');
  }

  GroundsModel.fromJson(Map<String, Object?> json)
      : this(
          groundName: json['groundName']! as String,
          address: json['address']! as String,
          imageUrl: json['imageUrl']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'groundName': groundName,
      'address': address,
      'imageUrl': imageUrl,
    };
  }

  Future<void> updateImageUrl() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('grounds');
    // Call the user's CollectionReference to add a new user

    Map<String, String> imageUrlMap = {'imageUrl': imageUrl};
    return users
        .doc(groundName)
        .update(imageUrlMap)
        .then((value) => print("Data updated"))
        .catchError((error) => print("Failed to update: $error"));
  }

  static void deleteData(GroundsModel groundModelObj) {
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

  Future<List<GroundsModel>> getGroundsList() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('grounds');
    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        Map<String, dynamic> data = result.data() as Map<String, dynamic>;
        groundsModelList.add(GroundsModel.fromJson(data));
      }
    });
    return groundsModelList;
  }

  Future<void> saveData() {
    CollectionReference grounds =
        FirebaseFirestore.instance.collection('grounds');
    // Call the user's CollectionReference to add a new user
    return grounds
        .doc(groundName)
        .set(toJson())
        .then((value) => print("Ground Added"))
        .catchError((error) => print("Failed to add ground: $error"));
  }

  final groundsList = FirebaseFirestore.instance
      .collection('grounds')
      .withConverter<GroundsModel>(
        fromFirestore: (snapshot, _) => GroundsModel.fromJson(snapshot.data()!),
        toFirestore: (Grounds_model, _) => Grounds_model.toJson(),
      );
}
