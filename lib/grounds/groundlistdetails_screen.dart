import 'package:flutter/material.dart';
import 'package:mycricplay/general/ImageUploads/AppFeature.dart';
import 'package:mycricplay/general/widgets/image_widget.dart';
import 'package:mycricplay/grounds/grounds_model.dart';

class GroundDetailsForm extends StatefulWidget {
  GroundsModel modelObj;
  GroundDetailsForm({Key? key, required this.modelObj}) : super(key: key);

  @override
  State<GroundDetailsForm> createState() => _GroundDetailsFormState();
}

class _GroundDetailsFormState extends State<GroundDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text('Ground details')),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(children: [
                    ImageWidget(
                      imageUrl: widget.modelObj.imageUrl,
                      appFeature: AppFeature.grounds,
                      imageUploadPath: 'Grounds/',
                      doImageCrop: true,
                    ),

                    TextFormField(
                      initialValue: widget.modelObj.groundName,
                      decoration:
                          const InputDecoration(label: Text('Ground name')),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter ground name';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          widget.modelObj.groundName = val!;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: widget.modelObj.address,
                      decoration: const InputDecoration(label: Text('Address')),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the address';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          widget.modelObj.address = val!;
                        });
                      },
                    ),
                    ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            widget.modelObj.saveData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        }),
                  ]),
                  key: _formKey,
                ),
              ),
            )));
  }

  _GroundDetailsFormState();
}
