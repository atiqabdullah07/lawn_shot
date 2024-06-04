import 'package:flutter/material.dart';
import 'package:lawn_shot/screens/home_screen.dart';
import 'package:lawn_shot/screens/login_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
    login: (context) => const LoginScreen(),
  };
}
