import 'package:flutter/material.dart';
import 'package:mycricplay/general/widgets/image_widget.dart';
import 'package:mycricplay/profile/controller/ProfileController.dart';
import '../../general/ImageUploads/AppFeature.dart';
import '../model/ProfileModel.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class UserProfileScreen extends GetView<ProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  Widget formWidget(ProfileModel modelObj, BuildContext context,
      ProfileController controller) {
    return SingleChildScrollView(
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.profileFormKey,
                child: Column(children: <Widget>[

                  ImageWidget(
                    imageUrl: modelObj.imageUrl   ,
                    appFeature: AppFeature.profile,
                    imageUploadPath: 'Profile/',
                    doImageCrop: false,
                  ),
                  TextFormField(
                    controller: controller.firstNameController,
                    decoration:
                        const InputDecoration(label: Text('First Name')),
                    onSaved: (value) {
                      controller.profileModel.firstName = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter first name';
                      }
                    },
                  ),
                  TextFormField(
                    controller: controller.lastNameController,
                    onSaved: (value) {
                      controller.lastName = value!;
                    },
                    decoration: const InputDecoration(label: Text('Last Name')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter last name';
                      }
                    },
                  ),
                  TextFormField(
                    controller: controller.dateOfBirthController,
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
                        controller.dateOfBirthController.text = formattedDate;
                        controller.profileModel.dateOfBirth = formattedDate;
                      }
                    },
                    decoration:
                        const InputDecoration(label: Text('Date of Birth')),
                  ),
                  TextFormField(
                    controller: controller.addressController,
                    maxLines: null,
                    decoration: const InputDecoration(label: Text('Address')),
                    onSaved: (value) {
                      controller.profileModel.address = value!;
                    },
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(label: Text('Email')),
                    onSaved: (value) {
                      controller.profileModel.email = value!;
                    },
                  ),
                  TextFormField(
                    controller: controller.mobileNumberController,
                    decoration:
                        const InputDecoration(label: Text('Mobile number')),
                    onSaved: (value) {
                      controller.profileModel.mobileNumber = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter mobile number';
                      }
                    },
                  ),
                  TextFormField(
                    controller: controller.emergencyContactController,
                    decoration:
                        const InputDecoration(label: Text('Emergency contact')),
                    onSaved: (value) {
                      controller.profileModel.emergencyContact = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter emergency contact';
                      }
                    },
                  ),
                  TextFormField(
                    controller: controller.personnelNumberController,
                    decoration:
                        const InputDecoration(label: Text('Personnel number')),
                    onSaved: (value) {
                      controller.profileModel.personnelNumber = value!;
                    },
                  ),

                ]))));
  }

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());


    return Scaffold(
      bottomNavigationBar:  ElevatedButton(
          child: const Text('Save'),
          onPressed: () {
            controller.saveData();
          }),
        appBar: AppBar(

          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              controller.onClose();
              Navigator.pop(context);
            },
          ),
          title: const Text('Profile'),
        ),
        body: FutureBuilder<ProfileModel>(
            future: controller.getCurrentUser(),
            builder: (context, userSnapshot) {
              try {
                if (userSnapshot.hasError) {
                  print(userSnapshot.error.toString());
                  return const Text('Something went wrong');
                }

                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Loading"));
                }


                return formWidget(controller.profileModel!, context, controller);
              } catch (error) {
                print(error.toString());
                return const Center(child: Text('Something went wrongs'));
              }
            }));
  }
}
