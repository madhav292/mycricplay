import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {

  final String buttonText;
  final Function() onPressed;

  const RoundedButton({Key? key, required this.buttonText,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
      child: Text(buttonText),
    );
  }
}

