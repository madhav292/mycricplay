import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            children: [
              SizedBox(height: 10,),

          TextFormField(
              // The validator receives the text that the user has entered.)
              validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          }),
              SizedBox(height: 10,),
          TextFormField(
            decoration: InputDecoration(hintText: 'Write something here...'),

            minLines: 6, // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: const Text('Click me')),
          )
        ]),
      ),
    );
  }
}
