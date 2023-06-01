import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycricplay/authentication/screens/register_screen.dart';
import 'package:mycricplay/authentication/services/authservice.dart';
import 'package:mycricplay/home/homescreen.dart';

import '../../general/widgets/roundedbutton_widget.dart';
import '../../general/widgets/roundedtextfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/titans_logo.jpeg',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 50),
                    ),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        bool isOnlyWhitespace = value.trim().isEmpty;

                        if (isOnlyWhitespace) {
                          return 'Blank spaces are not allowed in password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      onChanged: (value) {}),
                  RoundedButton(
                    buttonText: 'Login',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        AuthService authServiceCustom = AuthService();
                        var isSuccess = await authServiceCustom
                            .signInUserWithEmailAndPassword(
                                emailController.value.text,
                                passwordController.value.text);
                        if (isSuccess) {
                          Get.to(() => HomeScreen());
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: const Text('Sing up'),
                        onTap: () {
                          Get.to(const RegisterScreen());
                        },
                      ),
                      const SizedBox(
                        width: 50.0,
                      ),
                      const Text('Forgot Password')
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
    print('login dispose called');
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
