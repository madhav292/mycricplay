import 'package:cloud_firestore/cloud_firestore.dart';

class TeamsModel {
  String teamId;
  String teamName;
  String contactPerson;
  String contactNumber;
  String emailId;

  TeamsModel({
    required this.teamId,
    required this.teamName,
    required this.contactPerson,
    required this.contactNumber,
    required this.emailId,
  });

  static TeamsModel teamsModelNull() {
    return TeamsModel(
        teamId: '',
        teamName: '',
        contactNumber: '',
        contactPerson: '',
        emailId: '');
  }

  TeamsModel.fromJson(Map<String, Object?> json)
      : this(
            teamName: json['teamName']! as String,
            teamId: json['teamId']! as String,
            contactNumber: json['contactNumber']! as String,
            contactPerson: json['contactPerson']! as String,
            emailId: json['emailId']! as String);

  Map<String, Object?> toJson() {
    return {
      'teamId': teamId,
      'teamName': teamName,
      'contactPerson': contactPerson,
      'contactNumber': contactNumber,
      'emailId': emailId
    };
  }

  static void deleteData(TeamsModel groundModelObj) {
    FirebaseFirestore.instance
        .collection('teams')
        .doc(groundModelObj.teamName)
        .delete();
  }

  static Stream<QuerySnapshot> readData() {
    final Stream<QuerySnapshot> teamsStream =
        FirebaseFirestore.instance.collection('teams').snapshots();
    return teamsStream;
  }

  Future<void> saveData() {
    CollectionReference teams = FirebaseFirestore.instance.collection('teams');
    // Call the user's CollectionReference to add a new user
    return teams
        .doc(teamName)
        .set({
          'teamId': teamId,
          'teamName': teamName,
          'contactPerson': contactPerson,
          'contactNumber': contactNumber,
          'emailId': emailId
        })
        .then((value) => print("Team Added"))
        .catchError((error) => print("Failed to add team: $error"));
  }

  final teamsList = FirebaseFirestore.instance
      .collection('teams')
      .withConverter<TeamsModel>(
        fromFirestore: (snapshot, _) => TeamsModel.fromJson(snapshot.data()!),
        toFirestore: (TeamsModel, _) => TeamsModel.toJson(),
      );
}
