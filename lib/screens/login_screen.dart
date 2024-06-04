// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import 'package:lawn_shot/providers/auth_provider.dart';
import 'package:lawn_shot/widgets/custom_button.dart';
import 'package:lawn_shot/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  children: [
                    const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Welcome Back',
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password?",
                          style: TextStyle(
                              color: AppColors.primaryGreen, fontSize: 14),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    CustomButton(
                      title: "Sign In",
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          userProvider
                              .signInWithEmail(_emailController.text,
                                  _passwordController.text)
                              .then((_) {
                            if (userProvider.user != null) {
                              Navigator.pushReplacementNamed(context, '/home');
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
                      "Don't have an account?",
                      style: TextStyle(color: AppColors.black),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SignUp()),
                        // );
                      },
                      child: const Text(
                        " Sign Up here",
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












// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             if (userProvider.errorMessage != null)
//               Text(
//                 userProvider.errorMessage!,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             const SizedBox(height: 20),
//             userProvider.isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: () {
//                       userProvider
//                           .signInWithEmail(
//                               emailController.text, passwordController.text)
//                           .then((_) {
//                         if (userProvider.user != null) {
//                           Navigator.pushReplacementNamed(context, '/home');
//                         }
//                       });
//                     },
//                     child: const Text('Login'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
