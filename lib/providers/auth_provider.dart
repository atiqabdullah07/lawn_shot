// providers/user_provider.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? user;
  String? errorMessage;
  bool isLoading = false;
  bool isPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
    print(isPasswordVisible.toString());
  }

  Future<void> signInWithEmail(String email, String password) async {
    isLoading = true;
    easyLoading();
    notifyListeners();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        user = UserModel(name: firebaseUser.email ?? '', age: 0);
        errorMessage = null;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User does not exist.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'user-disabled':
          errorMessage = 'User account has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many login attempts. Try again later.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
      }
      log('Firebase Auth Exception: ${e.code} - ${e.message}');
    } catch (e) {
      errorMessage = 'An error occurred. Please try again.';
      log('General Exception: $e');
    } finally {
      isLoading = false;
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
