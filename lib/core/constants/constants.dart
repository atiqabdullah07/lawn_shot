import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppColors {
  static const primaryGreen = Color(0xFF89BB42);
  static const black = Color(0xFF000000);
  static const lightGrey = Color(0xFF868686);
  static const darkGrey = Color(0xFFBBBBBB);
}

void easyLoading() {
  EasyLoading.show(
    indicator: const CircularProgressIndicator(
      backgroundColor: AppColors.primaryGreen,
      color: Colors.teal,
    ),
    maskType: EasyLoadingMaskType.none,
    dismissOnTap: true,
  );
}
