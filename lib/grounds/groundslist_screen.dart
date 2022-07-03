import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:provider/provider.dart';

import 'groundlistdetails_screen.dart';

class GroundsList extends StatefulWidget {
  const GroundsList({Key? key}) : super(key: key);

  @override
  State<GroundsList> createState() => _GroundsListState();
}

class _GroundsListState extends State<GroundsList> {
  List<Widget> groundList = [];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _groundsStream =
        FirebaseFirestore.instance.collection('grounds').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _groundsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return MaterialApp(
              home: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GroundDetailsForm(new grounds_model())),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                  appBar: AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: const Text('Ground List')),
                  body: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GroundDetailsForm(new grounds_model())),
                        );
                      },
                      title: Text(data['ground_name']),
                      subtitle: Text(data['address']),
                      trailing: const Icon(Icons.edit),
                    );
                  }).toList())));
        });
  }
}
