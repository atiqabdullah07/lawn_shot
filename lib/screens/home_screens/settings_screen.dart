import 'package:flutter/material.dart';
import 'package:lawn_shot/core/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var setings = ['Edit Profile', 'Help & Feedback', 'About Us', 'Log Out'];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
        ),
        body: ListView.builder(
          itemCount: setings.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: setings[index] == 'Log Out'
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
                child: setings[index] == 'Log Out'
                    ? InkWell(
                        onTap: () {},
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
                                  setings[index],
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                setings[index],
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
            );
          },
        ));
  }
}
