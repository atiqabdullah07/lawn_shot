import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lawn_shot/core/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obsecureText;
  final bool isPasswordField;
  final VoidCallback? suffixTap;
  final String? Function(String?)? validator;

  const CustomTextField(
      {super.key,
      required this.hintText,
      this.suffixTap,
      this.isPasswordField = false,
      required this.controller,
      required this.obsecureText,
      required this.validator});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obsecureText,
      controller: widget.controller,
      onChanged: (value) {
        widget.controller.text = value;
      },
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.disabled,
      cursorColor: AppColors.primaryGreen,
      decoration: InputDecoration(
        suffixIcon: widget.isPasswordField == true
            ? GestureDetector(
                onTap: widget.suffixTap,
                child: const Icon(
                  Icons.remove_red_eye,
                ),
              )
            : const SizedBox(),
        labelText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.grey.withOpacity(0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
