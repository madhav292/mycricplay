import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/profile/profile_model.dart';

import 'package:mycricplay/teams/teams_model.dart';
import 'package:mycricplay/users/userdetails_screen.dart';

import '../general/ScreenLoading/loading_screen.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreen();
}

class _UsersListScreen extends State<UsersListScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: UserProfileModel.readAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading_Screen();
          }

          return MaterialApp(
              home: Scaffold(
                  appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: const Text('Players')),
                  body: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    UserProfileModel modelObj = UserProfileModel.fromJson(data);

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailsScreen(modelObj: modelObj)),
                        );
                      },
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(modelObj.imageUrl)),
                      title: Text(modelObj.firstName + ' ' + modelObj.lastName),
                      subtitle: Text(modelObj.mobileNumber),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  }).toList())));
        });
  }
}
