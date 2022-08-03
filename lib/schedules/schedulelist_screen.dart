import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../matches/MatchDetails.dart';

class ScheduleList extends StatefulWidget {
  const ScheduleList({Key? key}) : super(key: key);

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  late List<MatchDetails> listItems;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _schedulesStream =
        FirebaseFirestore.instance.collection('schedules').snapshots();

    Widget cardSample = Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: const Text('Card title 1'),
            subtitle: Text(
              'Secondary Text',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
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
          )
        ],
      ),
    );

    Widget scheudlecard = Card(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Fri,01 JULY 2022'.toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Text('Team A vs Team B',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text('Ground : Husby',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(
              '4 PM'.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red),
            ),
          ],
        ),
      ),
    );

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Schedules'),
      ),
      body: ListView(children: [
        cardSample,
      ]),
    ));
  }
}
