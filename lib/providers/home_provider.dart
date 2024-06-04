import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int selectedIndex = 0;

  void changeScreen(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
