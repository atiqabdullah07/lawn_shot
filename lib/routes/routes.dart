import 'package:flutter/material.dart';
import 'package:lawn_shot/screens/forget_password_screen.dart';
import 'package:lawn_shot/screens/home_screen.dart';
import 'package:lawn_shot/screens/home_screens/edit_profile_screen.dart';
import 'package:lawn_shot/screens/home_screens/lawn_screen.dart';
import 'package:lawn_shot/screens/home_screens/plant_details_screen.dart';
import 'package:lawn_shot/screens/home_screens/premium_plan_screen.dart';
import 'package:lawn_shot/screens/login_screen.dart';
import 'package:lawn_shot/screens/signup_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String paymentPlan = '/payment_plan';

  static const String forgetPassword = '/forget_password';

  static const String planDetails = '/plant_details_screen';
  static const String lawn = '/lawn_screen';
  static const String editProfile = '/edit_profile';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    forgetPassword: (context) => const ForgetPassword(),
    paymentPlan: (context) => const PremiumPlanScreen(),
    planDetails: (context) => const PlanDetailsScreen(),
    lawn: (context) => const LawnScreen(),
    editProfile: (context) => const EditProfileScreen(),
  };
}
