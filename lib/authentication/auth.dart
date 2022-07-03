import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseAuth.instanceFor(app: Firebase.app('CricPlay'));
  //Create user object based on FirebaseUser
  UserData? _userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  /*// Auth change user stream
  Stream<UserData> get userStream {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  } */

  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? firebaseUser = userCredential.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email and pwd

  // register with email & pwd

  // sing out

}
