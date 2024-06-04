import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawn_shot/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../core/constants/constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_textfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    void sendResetLink() async {
      try {
        await userProvider.resetPassword(email: _emailController.text);
        Future.delayed(const Duration(seconds: 0), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('A password reset link has been sent to your email.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        });
      } on FirebaseAuthException catch (e) {
        String message = 'An error occurred, please try again later.';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        }
        Future.delayed(const Duration(seconds: 0), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  const Text(
                    'Enter your email where the password reset link can be sent!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                      obsecureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }

                        String emailRegex =
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                        RegExp regex = RegExp(emailRegex);

                        if (!regex.hasMatch(value)) {
                          return 'Please Enter a Valid Email';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (userProvider.errorMessage != null)
                      Text(
                        userProvider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                  ],
                )),
            SizedBox(height: 30.h),
            CustomButton(
              title: 'Send Reset Link',
              onPress: () {
                FocusScope.of(context).unfocus();
                if (_emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email can\'t be empty!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  sendResetLink();
                }
              },
            ),
            SizedBox(height: 15.h),
            CustomButton(
              onPress: () {
                Navigator.pop(context);
              },
              title: 'Back to Login',
              color: AppColors.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
