import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;

  User? get user => _auth.currentUser;

  bool get isLoggedIn => user != null;

  Future<void> login(String email, String password) async {

    try {

      loading = true;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    } catch (e) {

      debugPrint(e.toString());

    }

    loading = false;
    notifyListeners();
  }

  Future<void> logout() async {

    await _auth.signOut();
    notifyListeners();
  }
}