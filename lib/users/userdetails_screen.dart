import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:mycricplay/teams/teams_model.dart';

import '../profile/profile_model.dart';

class UserDetailsScreen extends StatefulWidget {
  final profile_model? modelObj;
  const UserDetailsScreen({Key? key, required this.modelObj}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreen(modelObj);
}

class _UserDetailsScreen extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final profile_model? modelObj;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text('Player details')),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Form(
                  child: Column(children: [
                    TextFormField(
                      initialValue: modelObj!.firstName,
                      decoration:
                          const InputDecoration(label: Text('Team name')),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter team name';
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          modelObj?.lastName = val!;
                        });
                      },
                    ),
                    ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            modelObj?.saveData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        }),
                  ]),
                  key: _formKey,
                )),
              ),
            )));
  }

  _UserDetailsScreen(this.modelObj);
}
