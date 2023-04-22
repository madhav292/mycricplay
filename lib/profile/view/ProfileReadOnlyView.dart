import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:mycricplay/teams/teams_model.dart';

import '../model/ProfileModel.dart';

class ProfileReadOnlyView extends StatelessWidget {
  const ProfileReadOnlyView({Key? key}) : super(key: key);

  Widget getTextWidget(String name, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Text(value, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ProfileModel profileModel = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(profileModel.imageUrl),
            const SizedBox(
              height: 30,
            ),

            const SizedBox(
              height: 30,
            ),
            getTextWidget('First Name', profileModel.firstName),
            getTextWidget('Last Name', profileModel.lastName),
            getTextWidget('Date of Birth', profileModel.dateOfBirth),
            getTextWidget('Email', profileModel.email),
            getTextWidget('Mobile number', profileModel.mobileNumber),
          ],
        ),
      ),
    );
  }
}
