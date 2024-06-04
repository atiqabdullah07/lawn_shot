import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawn_shot/core/constants/constants.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    required this.onPress,
    this.color = AppColors.primaryGreen,
    this.nextIcon = false,
  });

  final String title;
  final VoidCallback onPress;
  Color color;
  bool nextIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(200, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 5,
            ),
            nextIcon == true
                ? const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: 20,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
