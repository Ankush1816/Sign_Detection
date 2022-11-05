import 'dart:developer';

import 'package:brew_for_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  Anom_User? _userfromFirebaseUser(User user) {
    return user != null ? Anom_User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Anom_User> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebaseUser(user!)!);
    // .map(_userfromFirebaseUser);
  }

  //sign in anonymous
  Future signInAnom() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userfromFirebaseUser(user!);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
    
      return _userfromFirebaseUser(user!);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString);
      return null;
    }
  }
}
