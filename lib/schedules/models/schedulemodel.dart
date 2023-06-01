import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ScheduleModel scheduleModelFromJson(String str) =>
    ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel(
      {
        required this.date,
      required this.fromTime,
      required this.toTime,
      required this.groundName,
      required this.description,
      required this.groundimageurl,
      required this.teamAName,
      required this.teamBName,
      required rsvpYes,
      required rsvpNo});

late String docId;
  String date;
  String fromTime;
  String toTime;
  String groundName;
  String description;
  String groundimageurl;
  String teamAName;
  String teamBName;
  var rsvpYes = [];
  var rsvpNo = [];

  static ScheduleModel getEmptyObject() {
    return ScheduleModel(

        date: '',
        fromTime: '',
        toTime: '',
        groundName: '',
        description: '',
        groundimageurl: '',
        teamAName: '',
        teamBName: '',
        rsvpYes: [],
        rsvpNo: []);
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(

        date: json["date"],
        fromTime: json["fromTime"],
        toTime: json["toTime"],
        groundName: json["groundName"],
        description: json["description"],
        groundimageurl: json["groundimageurl"],
        teamAName: json["teamAName"],
        teamBName: json["teamBName"],
        rsvpYes: List.from(json["rsvpYes"]),
        rsvpNo: List.from(json["rsvpNo"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "fromTime": fromTime,
        "toTime": toTime,
        "groundName": groundName,
        "description": description,
        "groundimageurl": groundimageurl,
        "teamAName": teamAName,
        "teamBName": teamBName,
        "rsvpYes": FieldValue.arrayUnion(rsvpYes),
        "rsvpNo": FieldValue.arrayUnion(rsvpNo),
      };
}
