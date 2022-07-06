import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading_Screen extends StatelessWidget {
  const Loading_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Text(
          'Loading',
          style: TextStyle(fontSize: 20),
        )),
      ),
    );
  }
}
