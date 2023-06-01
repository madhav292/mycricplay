import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:mycricplay/schedules/controllers/SearchGround.dart';
import 'package:mycricplay/schedules/controllers/schedulescontroller.dart';
import 'package:mycricplay/teams/TeamSearch.dart';
import 'package:mycricplay/utils/CustomDateTimeUtil.dart';

class SchedulesView extends StatelessWidget {
  late SchedulesController controller;

  SchedulesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = Get.put(SchedulesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Modify Sechedules'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.fromKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: null,
                  onSaved: (value) {
                    controller.model.description = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }
                  },
                ),
                TextFormField(
                  controller: controller.dateController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd-MM-yyyy').format(
                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      controller.dateController.text = formattedDate;
                      controller.model.date = formattedDate;
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text('Date'), prefixIcon: Icon(Icons.date_range)),
                  onSaved: (value) {
                    controller.model.date = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter date';
                    }
                  },
                ),
                TextFormField(
                  controller: controller.fromTimeController,
                  onTap: () async {
                    var timeStr = await CustomDateTimeUtil()
                        .getTimeStr12HrsFormat(context);
                    if (timeStr != '') {
                      controller.fromTimeController.text = timeStr;
                      controller.model.fromTime = timeStr;
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text('From '),
                      prefixIcon: Icon(Icons.access_time_outlined)),
                  onSaved: (value) {
                    controller.model.fromTime = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter start time';
                    }
                  },
                ),
                TextFormField(
                  controller: controller.toTimeController,
                  onTap: () async {
                    var timeStr = await CustomDateTimeUtil()
                        .getTimeStr12HrsFormat(context);

                    if (timeStr != '') {
                      controller.toTimeController.text = timeStr;
                      controller.model.toTime = timeStr;
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text('To'),
                      prefixIcon: Icon(Icons.access_time_outlined)),
                  onSaved: (value) {
                    controller.model.toTime = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter End Time';
                    }
                  },
                ),
                TextFormField(
                  controller: controller.groundNameController,
                  decoration: InputDecoration(
                    label: Text('Ground'),
                    prefixIcon: Icon(Icons.location_on_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                      ),
                      onPressed: () async {
                        final String? selected = await showSearch<String>(
                          context: context,
                          delegate: MySearchDelegate(),
                        );
                        if (selected != null) {
                          controller.groundNameController.text = selected;
                        }
                      },
                    ),
                  ),
                  onSaved: (value) {
                    controller.model.groundName = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select Ground';
                    }
                  },
                ),
                TextFormField(
                  controller: controller.teamANameController,
                  decoration:  InputDecoration(
                      label: Text('Team A'),
                      prefixIcon: Icon(Icons.person),
                    suffixIcon: IconButton(onPressed: () async {

                      final String? selected = await showSearch<String>(
                        context: context,
                        delegate: TeamSearch(),
                      );
                      if (selected != null) {
                        controller.teamANameController.text = selected;
                      }

                    }, icon: Icon(Icons.search))

                  ),
                  onSaved: (value) {
                    controller.model.teamAName = value!;
                  },
                  validator: (value) {
                   /* if (value!.isEmpty) {
                      return 'Please enter Team name';
                    }*/
                  },
                ),
                TextFormField(
                  controller: controller.teamBNameController,
                  decoration:  InputDecoration(
                      label: Text('Team B'),
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: IconButton(onPressed: () async {

                        final String? selected = await showSearch<String>(
                          context: context,
                          delegate: TeamSearch(),
                        );
                        if (selected != null) {
                          controller.teamBNameController.text = selected;
                        }

                      }, icon: Icon(Icons.search))

                  ),
                  onSaved: (value) {
                    controller.model.teamAName = value!;
                  },
                  validator: (value) {
                   /* if (value!.isEmpty) {
                      return 'Please enter Team name';
                    }*/
                  },
                ),

                ElevatedButton(
                  onPressed: () {
                    controller.saveData();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
