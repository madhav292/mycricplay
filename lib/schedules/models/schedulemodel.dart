
import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel({
    required this.date,
    required this.fromTime,
    required this.toTime,
    required this.groundName,
    required this.description,
    required this.groundimageurl,
    required this.teamName
  });

  String date;
  String fromTime;
  String toTime;
  String groundName;
  String description;
  String groundimageurl;
  String teamName;

  static ScheduleModel getEmptyObject()
  {
    return ScheduleModel(date: '', fromTime: '', toTime: '', groundName: '', description: '', groundimageurl: '',teamName: '');
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    date: json["date"],
    fromTime: json["fromTime"],
    toTime: json["toTime"],
    groundName: json["groundName"],
    description: json["description"],
    groundimageurl: json["groundimageurl"],
    teamName: json["teamName"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "fromTime": fromTime,
    "toTime":toTime,
    "groundName": groundName,
    "description": description,
    "groundimageurl": groundimageurl,
    "teamName": teamName,
  };
}