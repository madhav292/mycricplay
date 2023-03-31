import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mycricplay/teams/teams_model.dart';

import '../general/ScreenLoading/loading_screen.dart';
import 'teamdetails_screen.dart';

class TeamsListScreen extends StatefulWidget {
  const TeamsListScreen({Key? key}) : super(key: key);

  @override
  State<TeamsListScreen> createState() => _TeamsListScreen();
}

class _TeamsListScreen extends State<TeamsListScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: TeamsModel.readData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading_Screen();
          }

          return MaterialApp(
              home: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeamDetails_Screen(
                                teamsModelObj: TeamsModel.teamsModelNull())),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                  appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: const Text('Team List')),
                  body: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    TeamsModel teamsModelObj = TeamsModel.fromJson(data);

                    return Dismissible(
                      key: Key(teamsModelObj.teamName),
                      onDismissed: (direction) {
                        TeamsModel.deleteData(teamsModelObj);
                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Deleted')));
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      // Remove the item from the data source.

                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamDetails_Screen(
                                    teamsModelObj: teamsModelObj)),
                          );
                        },
                        title: Text(data['teamName']),
                        subtitle: Text(data['contactPerson']),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  }).toList())));
        });
  }
}
