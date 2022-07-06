import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:provider/provider.dart';

import '../general/ScreenLoading/loading_screen.dart';
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
        stream: Grounds_model.readData(),
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
                            builder: (context) => GroundDetailsForm(
                                groundsModelObj: Grounds_model(
                                    groundName: "", address: ''))),
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
                      title: const Text('Ground List')),
                  body: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    Grounds_model grounds_modelObj =
                        Grounds_model.fromJson(data);

                    return Dismissible(
                      key: Key(grounds_modelObj.groundName),
                      onDismissed: (direction) {
                        Grounds_model.deleteData(grounds_modelObj);
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
                                builder: (context) => GroundDetailsForm(
                                    groundsModelObj: grounds_modelObj)),
                          );
                        },
                        title: Text(data['groundName']),
                        subtitle: Text(data['address']),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  }).toList())));
        });
  }
}
