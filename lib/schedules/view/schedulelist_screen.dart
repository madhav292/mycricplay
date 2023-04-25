import 'package:cloud_firestore/cloud_firestore.dart';
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
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title:  Text(
                model.teamName,
                style: TextStyle(fontSize: 30),
              ),
              subtitle: Text(
                model.groundName,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                model.description,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                model.date + ' '+ model.fromTime +' to '+ model.toTime ,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('RSVP'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),

            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Row(
                children: [ Text('In:    '),
                 ],
              ),
            ),
            Row(
              children: [ Text('Out: '),
                Icon(Icons.person),Icon(Icons.person),Icon(Icons.person)],
            )


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
          body: FutureBuilder<Object>(
              future: controller.getSchedulesList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading_Screen();
                }
                return ListView.builder(
                  itemCount: controller.schedulesModelList.length,
                  itemBuilder: (BuildContext,int){
                    return cardSample(controller.schedulesModelList[int]);
                  },);
              }
          ),
        ),
      );
    }
}
