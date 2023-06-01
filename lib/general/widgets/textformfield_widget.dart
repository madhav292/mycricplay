import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String inputValue) onChanged;
  final TextEditingController? controller;

  const TextFormFieldWidget(
      {Key? key,
      required this.hintText,
      this.obscureText = false,
      required this.onChanged,
      required this.labelText,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidget();
}

class _TextFormFieldWidget extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(15),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
      controller: widget.controller,
    );
  }
}
