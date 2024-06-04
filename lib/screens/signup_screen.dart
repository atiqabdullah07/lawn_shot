import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import 'package:lawn_shot/providers/auth_provider.dart';
import 'package:lawn_shot/screens/login_screen.dart';
import 'package:lawn_shot/widgets/custom_button.dart';
import 'package:lawn_shot/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    const Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Add your credentials or sign up with your social account',
                        style: TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Username',
                              controller: _userNameController,
                              obsecureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a Username';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
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
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              isPasswordField: true,
                              obsecureText:
                                  userProvider.isPasswordVisible == true
                                      ? true
                                      : false,
                              controller: _passwordController,
                              hintText: "Enter your Password",
                              suffixTap: () {
                                userProvider.changePasswordVisibility();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a password';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              isPasswordField: true,
                              obsecureText:
                                  userProvider.isPasswordVisible == true
                                      ? true
                                      : false,
                              controller: _confirmPasswordController,
                              hintText: "Confirm Password",
                              suffixTap: () {
                                userProvider.changePasswordVisibility();
                              },
                              validator: (value) {
                                if (value == null ||
                                    value !=
                                        _passwordController.text.toString()) {
                                  return 'Passwords do not match';
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
                    SizedBox(
                      height: 50.h,
                    ),
                    CustomButton(
                      title: "Sign Up",
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          userProvider
                              .createUserWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                  _userNameController.text)
                              .then((_) {
                            if (userProvider.user != null) {
                              Navigator.of(context).pop();
                              // Navigator.pushReplacementNamed(context, '/login');
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: AppColors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        " SignIn here",
                        style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
