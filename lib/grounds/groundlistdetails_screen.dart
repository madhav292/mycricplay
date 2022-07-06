import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/grounds/grounds_model.dart';

class GroundDetailsForm extends StatefulWidget {
  final Grounds_model? groundsModelObj;
  const GroundDetailsForm({Key? key, required this.groundsModelObj})
      : super(key: key);

  @override
  State<GroundDetailsForm> createState() =>
      _GroundDetailsFormState(groundsModelObj);
}

class _GroundDetailsFormState extends State<GroundDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final Grounds_model? grounds_modelsObj;
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
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text('Ground details')),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Form(
                  child: Column(children: [
                    TextFormField(
                      initialValue: grounds_modelsObj!.groundName,
                      decoration: InputDecoration(label: Text('Ground name')),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter ground name';
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          grounds_modelsObj?.groundName = val!;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: grounds_modelsObj!.address,
                      decoration: InputDecoration(label: Text('Address')),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the address';
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          grounds_modelsObj?.address = val!;
                        });
                      },
                    ),
                    ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            grounds_modelsObj?.saveData();
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

  _GroundDetailsFormState(this.grounds_modelsObj);
}
