import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mycricplay/authentication/services/authgate.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/profile/view/ProfileView.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(

    theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark,
      useMaterial3: true),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
      routes: {'/profile_screen': (context) => const UserProfileScreen()}));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const AuthGate();
  }
}
