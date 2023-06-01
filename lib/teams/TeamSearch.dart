import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/teams/teams_model.dart';

class TeamSearch extends SearchDelegate<String> {
  List<String> teamList = ['one', 'two', 'three'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (query.isEmpty) {
          close(context, '');
        } else {
          query = '';
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> searchList = teamList
        .where((word) => word.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchList[index]),
          onTap: () {
            close(context, searchList[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    teamList.clear();

    List<TeamsModel> groundsModelList;
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('teams').get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            "Something went wrong",
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            teamList.add(data['teamName']);
            return ListTile(
              onTap: (){
                close(context, data['teamName']);
              },
              title: Text(data['teamName']), // 👈 Your valid data here
            );
          }).toList());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
