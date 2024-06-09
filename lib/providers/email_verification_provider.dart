import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationProvider with ChangeNotifier {
  Timer? _timer;
  int _secondsRemaining = 0;

  int get secondsRemaining => _secondsRemaining;

  void startEmailVerificationCheck(Function onVerified) {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      if (user != null && user.emailVerified) {
        timer.cancel();
        onVerified();
      }
    });
  }

  Future<void> sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      _secondsRemaining = 30;
      notifyListeners();
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining <= 0) {
          timer.cancel();
        } else {
          _secondsRemaining--;
          notifyListeners();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
