import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mycricplay/general/ImageUploads/ImageUploadUtil.dart';

import 'profile_model.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserProfile_Screen extends StatefulWidget {
  const UserProfile_Screen({Key? key}) : super(key: key);

  @override
  State<UserProfile_Screen> createState() => _UserProfile_ScreenState();
}

class _UserProfile_ScreenState extends State<UserProfile_Screen> {
  profile_model _profile_model = profile_model();
  String dropdownValue = 'Male';
  final firestoreInstance = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  void _read() async {
    DocumentSnapshot documentSnapshot;
    User _loginUser;
    FirebaseAuth auth = FirebaseAuth.instance;
    _loginUser = FirebaseAuth.instance.currentUser!;
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(_loginUser.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      _profile_model.firstName = data?['firstName'];
      print(_profile_model.gender);
      _profile_model.lastName = data?['lastName'];

      _profile_model.mobileNumber = data?['mobileNumber'];
      _profile_model.emergencyContact = data?['emergencyContact'];
      _profile_model.email = data?['email'];
      _profile_model.address = data?['address'];
      _profile_model.dateOfBirth = data?['dateOfBirth'];
      _profile_model.gender = data?['gender'];
    }
  }

  Widget addTextFieled(String _hintText) {
    return TextFormField(
      decoration: InputDecoration(hintText: _hintText),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_profile_model.firstName);
    _read();
    return MaterialApp(
        home: Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Profile'),
        ),
        body: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading data');
              return SingleChildScrollView(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          ImageUploadUtil.getImageUploadWidget(context),
                          TextFormField(
                            initialValue: _profile_model.firstName,
                            decoration:
                                InputDecoration(label: Text('First Name')),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter first name';
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                _profile_model.firstName = val!;
                              });
                            },
                          ),
                          TextFormField(
                            initialValue: _profile_model.lastName,
                            decoration:
                                InputDecoration(label: Text('Last Name')),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter last name';
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                _profile_model.lastName = val!;
                              });
                            },
                          ),

                          TextFormField(
                            initialValue: _profile_model.personnelNumber,
                            decoration: InputDecoration(
                                label: Text('Personnel number')),
                            onSaved: (val) {
                              setState(() {
                                _profile_model.personnelNumber = val!;
                              });
                            },
                          ),

                          TextFormField(
                            initialValue: _profile_model.mobileNumber,
                            decoration:
                                InputDecoration(label: Text('Mobile number')),
                            onSaved: (val) {
                              setState(() {
                                _profile_model.mobileNumber = val!;
                              });
                            },
                          ),
                          TextFormField(
                            initialValue: _profile_model.emergencyContact,
                            decoration: InputDecoration(
                                label: Text('Emergency number')),
                            onSaved: (val) {
                              setState(() {
                                _profile_model.emergencyContact = val!;
                              });
                            },
                          ),

                          TextFormField(
                            initialValue: _profile_model.address,
                            decoration: InputDecoration(label: Text('Addess')),
                            onSaved: (val) {
                              setState(() {
                                _profile_model.address = val!;
                              });
                            },
                          ),

                          ElevatedButton(
                              child: Text('Save'),
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  _profile_model.saveData();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              }),

                          // Add TextFormFields and ElevatedButton here.
                        ],
                      ),
                    )),
              );
            }),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadData() async {}
}
