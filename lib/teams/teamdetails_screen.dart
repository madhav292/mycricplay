import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:mycricplay/teams/teams_model.dart';

class TeamDetails_Screen extends StatefulWidget {
  final TeamsModel? teamsModelObj;
  const TeamDetails_Screen({Key? key, required this.teamsModelObj})
      : super(key: key);

  @override
  State<TeamDetails_Screen> createState() => _TeamDetails_Screen(teamsModelObj);
}

class _TeamDetails_Screen extends State<TeamDetails_Screen> {
  final _formKey = GlobalKey<FormState>();
  final TeamsModel? teamsModelObj;
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
                title: const Text('Team details')),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Form(
                  child: Column(children: [
                    TextFormField(
                      initialValue: teamsModelObj!.teamName,
                      decoration:
                          const InputDecoration(label: Text('Team name')),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter team name';
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          teamsModelObj?.teamName = val!;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: teamsModelObj!.contactPerson,
                      decoration:
                          const InputDecoration(label: Text('Contact person')),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the contact person';
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          teamsModelObj?.contactPerson = val!;
                        });
                      },
                    ),
                    ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            teamsModelObj?.saveData();
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

  _TeamDetails_Screen(this.teamsModelObj);
}
