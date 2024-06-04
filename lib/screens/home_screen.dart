// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import 'package:lawn_shot/providers/auth_provider.dart';
import 'package:lawn_shot/providers/home_provider.dart';
import 'package:lawn_shot/screens/home_screens/dashboard_screen.dart';
import 'package:lawn_shot/screens/home_screens/lawn_screen.dart';
import 'package:lawn_shot/screens/home_screens/scan_screen.dart';
import 'package:lawn_shot/screens/home_screens/settings_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    ScanScreen(),
    LawnScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(homeProvider.selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home.svg', // Path to your SVG asset
              height: 24,
              width: 24,
              color: homeProvider.selectedIndex == 0
                  ? AppColors.primaryGreen
                  : Colors.grey.shade300,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/scan.svg', // Path to your SVG asset
              height: 24,
              width: 24,
              color: homeProvider.selectedIndex == 1
                  ? AppColors.primaryGreen
                  : Colors.grey.shade300,
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/lawn.svg', // Path to your SVG asset
              height: 24,
              width: 24,
              color: homeProvider.selectedIndex == 2
                  ? AppColors.primaryGreen
                  : Colors.grey.shade300,
            ),
            label: 'Lawn',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/settings.svg', // Path to your SVG asset
              height: 24,
              width: 24,
              color: homeProvider.selectedIndex == 3
                  ? AppColors.primaryGreen
                  : Colors.grey.shade300,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: homeProvider.selectedIndex,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey.shade400,
        onTap: (int index) {
          homeProvider.changeScreen(index);
        },
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
