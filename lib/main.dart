import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mycricplay/authentication/AuthGate.dart';

import 'package:mycricplay/matches/MatchDetails.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/profile/profile_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      routes: {'/profile_screen': (context) => const UserProfileScreen()}));
}

class MyApp extends StatelessWidget {
  List<MatchDetails> listItems = List<MatchDetails>.generate(100,
      (i) => MatchDetails("Match $i", "14/04/2022", "9 AM - 2 PM", "Husby"));

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const AuthGate();
  }
}
