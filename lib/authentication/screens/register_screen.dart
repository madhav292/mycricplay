import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycricplay/authentication/screens/login_screen.dart';
import 'package:mycricplay/authentication/services/authservice.dart';
import 'package:mycricplay/home/homescreen.dart';
import '../../general/widgets/roundedbutton_widget.dart';
import '../../general/widgets/roundedtextfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 50),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RoundedTextField(
                    labelText: 'User name',
                    hintText: 'Enter your email id',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email id';
                      }
                      if (!value.isEmail) {
                        return 'Please enter valid email id';
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedTextField(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    obscureText: true,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: passwordController,
                  ),
                  RoundedButton(
                    buttonText: 'Register',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        AuthService authService = AuthService();
                        var isSuccess =
                            await authService.createUserWithEmailAndPassword(
                                emailController.value.text,
                                passwordController.value.text);
                        if (isSuccess) {
                          Get.to(() =>  HomeScreen());
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('Log in'),
                      SizedBox(
                        width: 50.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('register dispose called');
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
