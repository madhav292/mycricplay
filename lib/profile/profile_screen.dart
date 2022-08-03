import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:mycricplay/general/ImageUploads/AppFeature.dart';
import 'package:mycricplay/general/ImageUploads/ImageUploadUtil.dart';
import 'profile_model.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String dropdownValue = 'Male';
  String imagePickOption = 'Gallery';

  TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          ImageUploadUtil imageUploadUtil = ImageUploadUtil(
              imageUploadPath: 'ProfileImages/',
              doImageCrop: true,
              appFeature: AppFeature.profile);
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Upload image from',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () async {
                      imageUploadUtil.imgFromGallery();

                      Navigator.of(context).pop(imagePickOption);
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imageUploadUtil.imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(
                  color: Colors.black,
                ),
                ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Remove'),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        });
  }

  Widget addTextField(String _hintText) {
    return TextFormField(
      decoration: InputDecoration(hintText: _hintText),
    );
  }

  Widget imageWidget(UserProfileModel modelObj) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: Column(
            children: [
              modelObj.imageUrl != ''
                  ? Image.network(modelObj.imageUrl,
                      fit: BoxFit.cover,
                      width: 800,
                      height: 250, errorBuilder: (context, error, stackTrace) {
                      return const Text('Error loading image');
                    })
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 600,
                      height: 240,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ],
          ),
          onTap: () async {
            showPicker(context);
          },
        )
      ],
    );
  }

  _UserProfileScreenState();

  Widget firstNameWidget(UserProfileModel modelObj) {
    return TextFormField(
      initialValue: modelObj.firstName,
      decoration: const InputDecoration(label: Text('First Name')),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter first name';
        }
      },
      onSaved: (val) {
        setState(() {
          modelObj.firstName = val!;
        });
      },
    );
  }

  Widget lastNameWidget(UserProfileModel modelObj) {
    return TextFormField(
      initialValue: modelObj.lastName,
      decoration: const InputDecoration(label: Text('Last Name')),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter last name';
        }
      },
      onSaved: (val) {
        setState(() {
          modelObj.lastName = val!;
        });
      },
    );
  }

  Widget dateOfBirthWidget(UserProfileModel modelObj, context) {
    return TextFormField(
      controller: dateController,
      onTap: () async {
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
        }
      },
      decoration: const InputDecoration(label: Text('Date of Birth')),
      onSaved: (val) {
        setState(() {
          modelObj.dateOfBirth = val!;
        });
      },
    );
  }

  Widget personnelNumWidget(UserProfileModel modelObj) {
    return TextFormField(
      initialValue: modelObj.personnelNumber,
      decoration: const InputDecoration(label: Text('Personnel number')),
      onSaved: (val) {
        setState(() {
          modelObj.personnelNumber = val!;
        });
      },
    );
  }

  Widget phoneNumberWidget(UserProfileModel modelObj) {
    return TextFormField(
      initialValue: modelObj.mobileNumber,
      decoration: const InputDecoration(label: Text('Mobile number')),
      onSaved: (val) {
        setState(() {
          modelObj.mobileNumber = val!;
        });
      },
    );
  }

  Widget emergencyContactWidget(UserProfileModel modelObj) {
    return TextFormField(
      initialValue: modelObj.emergencyContact,
      decoration: const InputDecoration(label: Text('Emergency number')),
      onSaved: (val) {
        setState(() {
          modelObj.emergencyContact = val!;
        });
      },
    );
  }

  Widget addressWidget(UserProfileModel modelObj) {
    return TextFormField(
      initialValue: modelObj.address,
      decoration: const InputDecoration(label: Text('Address')),
      onSaved: (val) {
        setState(() {
          modelObj.address = val!;
        });
      },
    );
  }

  Widget saveButtonWidget(UserProfileModel modelObj) {
    return ElevatedButton(
        child: const Text('Save'),
        onPressed: () {
          final form = _formKey.currentState;
          if (form!.validate()) {
            form.save();
            modelObj.saveData();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Update successful')),
            );
          }
        });
  }

  Widget formWidget(UserProfileModel modelObj) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                imageWidget(modelObj),
                firstNameWidget(modelObj),
                lastNameWidget(modelObj),
                dateOfBirthWidget(modelObj, context),
                personnelNumWidget(modelObj),
                phoneNumberWidget(modelObj),
                emergencyContactWidget(modelObj),
                addressWidget(modelObj),
                saveButtonWidget(modelObj)

                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Profile'),
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: UserProfileModel.readCurUserSnapShot(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              try {
                UserProfileModel modelObj;
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                if (snapshot.data!.data() == null) {
                  modelObj = UserProfileModel.userProfileModelNewObj();
                  modelObj.saveData();
                }
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                modelObj = Get.put(UserProfileModel.fromJson(data));
                //UserProfileModel modelObj =
                //    UserProfileModel.userProfileModelNewObj();
                dateController.text = modelObj.dateOfBirth;

                return formWidget(modelObj);
              } catch (error) {
                return const Center(child: Text('Something went wrong'));
              }
            }));
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadData() async {}
}
