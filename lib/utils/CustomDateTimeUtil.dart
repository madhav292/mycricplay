import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimeUtil {
  Future<String> getTimeStr12HrsFormat(BuildContext context) async {
    String retTime='';

    ///Time
    TimeOfDay timeOfDay = TimeOfDay.now();
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      // Conversion logic starts here
      DateTime tempDate = DateFormat("hh:mm").parse("${time!.hour}:${time!.minute}");
      var dateFormat = DateFormat("h:mm a"); // you can change the format here
      retTime = dateFormat.format(tempDate);
    }

    return retTime;
  }
}
