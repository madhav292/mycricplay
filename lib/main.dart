import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:mycricplay/authentication/AuthGate.dart';

import 'package:mycricplay/home/home.dart';
import 'package:mycricplay/matches/MatchDetails.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/profile/profile_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: true,
      home: MyApp(),
      routes: {'/profile_screen': (context) => const UserProfile_Screen()}));
}

class MyApp extends StatelessWidget {
  List<MatchDetails> listItems = List<MatchDetails>.generate(
      100,
      (i) =>
          new MatchDetails("Match $i", "14/04/2022", "9 AM - 2 PM", "Husby"));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthGate();
  }
}
