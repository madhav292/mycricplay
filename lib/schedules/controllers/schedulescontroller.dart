import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mycricplay/grounds/grounds_model.dart';
import 'package:mycricplay/schedules/models/schedulemodel.dart';
import 'package:intl/intl.dart';

class SchedulesController extends GetxController {
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController(
      text: DateFormat('yMd').format(DateTime.now()));
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController groundNameController = TextEditingController();
  TextEditingController teamANameController = TextEditingController();
  TextEditingController teamBNameController = TextEditingController();

  List<ScheduleModel> schedulesModelList = [];
  ScheduleModel model = ScheduleModel.getEmptyObject();

  List<GroundsModel> groundsModelList = [];

  void setDataToModel() {
    model.date = dateController.value.text;
    model.description = descriptionController.value.text;
    model.fromTime = fromTimeController.value.text;
    model.toTime = toTimeController.value.text;
    model.groundName = groundNameController.value.text;
    model.teamAName = teamANameController.value.text;
    model.teamBName = teamBNameController.value.text;
  }

  void setDataToControls() {
    /* dateController = TextEditingController(text: profileModel.firstName);
    lastNameController = TextEditingController(text: profileModel.lastName);
    dateOfBirthController = TextEditingController(text:profileModel.dateOfBirth);
    addressController = TextEditingController(text:profileModel.address);
    mobileNumberController = TextEditingController(text: profileModel.mobileNumber);
    emergencyContactController = TextEditingController(text: profileModel.emergencyContact);
    emailController = TextEditingController(text: profileModel.email);
    personnelNumberController =TextEditingController(text: profileModel.personnelNumber);
    //genderController = TextEditingController(text: )*/
  }

  Future<List<ScheduleModel>> getSchedulesList() async {
    schedulesModelList = [];
    try {
      final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('schedules');

      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          Map<String, dynamic> data = result.data() as Map<String, dynamic>;

          schedulesModelList.add(ScheduleModel.fromJson(data));
          print(ScheduleModel.fromJson(data));

        }
      });
    } catch (exception) {}
    finally {}


    return schedulesModelList;
  }

  Stream<QuerySnapshot> getSchedulesStream() {
  final Stream<QuerySnapshot> schedulesStream = FirebaseFirestore.instance
      .collection('schedules').snapshots();

  return schedulesStream;
}



  Future<void> saveDataFirebase() {

    CollectionReference schedules = FirebaseFirestore.instance.collection('schedules');

    return schedules
        .doc()
        .set(model.toJson())
        .then((value) => print("Data saved"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateRSVP() {

    CollectionReference schedules = FirebaseFirestore.instance.collection('schedules');

    return schedules
        .doc(model.docId)
        .set(model.toJson())
        .then((value) => print("Data saved"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void saveData() {
    if (fromKey.currentState!.validate()) {
      setDataToModel();
      saveDataFirebase();
    }
  }
  @override
  Future<void> onInit() async {
    super.onInit();
    GroundsModel groundsModel = GroundsModel.GroundsModelObj();


   groundsModelList = await  groundsModel.getGroundsList();

  }
}
