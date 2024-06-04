// providers/user_provider.dart
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import '../models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserProvider with ChangeNotifier {
  UserModel? user;
  String? errorMessage;
  bool isLoading = false;
  bool isPasswordVisible = false;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
    print(isPasswordVisible.toString());
  }

  Future<UserModel?> _fetchUserData(auth.User? firebaseUser) async {
    if (firebaseUser == null) {
      return null;
    }

    var snapshot =
        await _firestore.collection('users').doc(firebaseUser.uid).get();
    var userData = snapshot.data();

    bool isPremium = userData?['isPremium'] ?? false;
    String? userName = userData?['userName'] ?? '';

    user = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        userName: userName!,
        isPremium: isPremium);

    return user;
  }

  Future<bool> signInWithEmail(String email, String password) async {
    isLoading = true;
    easyLoading();
    notifyListeners();
    try {
      auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      auth.User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        await _fetchUserData(userCredential.user);
        errorMessage = null;
        return true;
      }
    } on auth.FirebaseAuthException catch (e) {
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
    return false;
  }

  Future<UserModel?> createUserWithEmailAndPassword(
    String email,
    String password,
    String userName,
  ) async {
    isLoading = true;
    easyLoading();
    notifyListeners();
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final firebaseUser = credential.user;

      if (firebaseUser != null) {
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'email': firebaseUser.email,
          'userName': userName,
          'isPremium': false,
        });

        errorMessage = null;
        return _fetchUserData(firebaseUser);
      }
    } on auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'The email address is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
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
    return null;
  }

  Future<void> resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePremiumStatus(bool status) async {
    if (user != null) {
      await _firestore.collection('users').doc(user!.uid).update({
        'isPremium': status,
      });
      await _fetchUserData(_auth.currentUser);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
