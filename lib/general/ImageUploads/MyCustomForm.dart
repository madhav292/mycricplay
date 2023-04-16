import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCustomForm extends StatelessWidget {
  var numberVal = 10.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 250,
                child: Image.asset(
                  'assets/images/titans_logo.jpeg',
                )),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email',labelText: 'Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Password',labelText: 'Password'),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Forgot password',style: TextStyle(color: Colors.blue),),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(


                  onPressed: () {
                    numberVal++;
                  },
                  child: const Text('Login',style: TextStyle(fontSize: 20),)
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("New User?, Create account",style: TextStyle(fontSize: 20)),
          ],
         ),
        ),
      ),
    );
  }
}
