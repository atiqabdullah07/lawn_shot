import 'package:flutter/material.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import 'package:lawn_shot/providers/auth_provider.dart';
import 'package:lawn_shot/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    var settings = ['Edit Profile', 'Help & Feedback', 'About Us', 'Log Out'];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: settings[index] == 'Log Out'
                  ? const EdgeInsets.symmetric(horizontal: 25, vertical: 65)
                  : const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Shadow color
                      spreadRadius: 0, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: settings[index] == 'Log Out'
                    ? InkWell(
                        onTap: () {
                          userProvider.signOut();
                          Provider.of<HomeProvider>(context, listen: false)
                              .selectedIndex = 0;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (Route<dynamic> route) => false);
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.logout,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  settings[index],
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: GestureDetector(
                            onTap: () {
                              if (settings[index] == 'Edit Profile') {
                                Navigator.pushNamed(context, '/edit_profile');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  settings[index],
                                  style: const TextStyle(
                                      color: AppColors.black, fontSize: 18),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            );
          },
        ));
  }
}
