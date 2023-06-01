import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mycricplay/general/ScreenLoading/loading_screen.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:mycricplay/schedules/controllers/schedulescontroller.dart';
import 'package:mycricplay/schedules/models/schedulemodel.dart';
import 'package:mycricplay/schedules/view/SechedulesView.dart';

import '../../matches/MatchDetails.dart';

class ScheduleList extends StatelessWidget {
  ScheduleList({Key? key}) : super(key: key);

  late List<MatchDetails> listItems;

  late SchedulesController controller;

  List<GroundsModel> groundsModelList = [];

  @override
  Widget build(BuildContext context) {
    controller = Get.put(SchedulesController());

    Widget cardSample(ScheduleModel model) {

      print(model.rsvpYes);
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                model.description,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(Icons.date_range),
                  Text(
                    model.date,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(Icons.access_time_outlined),
                  Text(
                    model.fromTime + ' to ' + model.toTime,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Text(
                    model.groundName,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),


                ElevatedButton(
                  onPressed: () {
                    
                    model.rsvpYes.add(FirebaseAuth.instance.currentUser?.uid);
                    controller.model = model;
                    controller.updateRSVP();
                  },
                  child: const Text('RSVP'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),




                 SizedBox(
                   height: 50,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                       itemCount: model.rsvpYes.length,
                     itemBuilder: (context,index){



                     return   Icon(Icons.person);
                   },)
                 ),

            SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.rsvpNo.length,
                  itemBuilder: (context,index){



                    return Icon(Icons.person);
                  },)
            )



      /* Row(
              children: [
                Text('Out: '),
                Icon(Icons.person),
                Icon(Icons.person),
                Icon(Icons.person)
              ],
            )*/
          ],
        ),
      );
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: IconButton(
            iconSize: 50,
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(SchedulesView());
            },
          ),
          appBar: AppBar(
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Schedules'),
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: controller.getSchedulesStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    print(data);
                    var listYes = List.from(data['rsvpYes']);
                    var listNo = List.from(data['rsvpNo']);
                    ScheduleModel scheduleModelObj = ScheduleModel.fromJson(data);
                    scheduleModelObj.docId = document.id;
                    scheduleModelObj.rsvpNo = listNo;
                    scheduleModelObj.rsvpYes = listYes;
                     return cardSample(scheduleModelObj);
                  }).toList(),
                );
              }),
        ));
  }
}
