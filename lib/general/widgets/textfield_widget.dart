import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  String initialValue;
  TextEditingController textEditingController;
  String inputDecorationText;
  Function onSaved;

  AppTextFormField(
      {Key? key,
      required this.textEditingController,
      this.initialValue = '',
      this.inputDecorationText = '',
      required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(label: Text(inputDecorationText)),
    );
  }
}
