import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomAuthProvider with ChangeNotifier {
  UserCredential? _userCredential;

  UserCredential? get userCredential => _userCredential;

  void setUserCredential(UserCredential userCredential) {
    _userCredential = userCredential;
    notifyListeners();
  }

  UserCredential? getUserCredential() {
    return _userCredential;
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    _userCredential = null;
    notifyListeners();
  }
}
