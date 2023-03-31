import 'package:flutter/material.dart';
import 'package:mycricplay/profile/profile_model.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  TextEditingController dateController = TextEditingController();
  late UserProfileModel modelObj;
  DateWidget({Key? key, required UserProfileModel modelObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: dateController,
      onTap: () async {
        print(modelObj.dateOfBirth);
        /*
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate:
                DateTime.parse(modelObj.dateOfBirth), //get today's date
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(
              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

          dateController.text = formattedDate;
          modelObj.dateOfBirth = formattedDate;
        }*/
      },
      decoration: const InputDecoration(label: Text('Date of Birth')),
    );
    ;
  }
}
