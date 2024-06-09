import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import 'package:lawn_shot/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class PlantDiseaseDetails extends StatefulWidget {
  const PlantDiseaseDetails(
      {super.key, required this.image, required this.diseaseDetxected});

  final File image;
  final String diseaseDetxected;

  @override
  State<PlantDiseaseDetails> createState() => _PlantDiseaseDetailsState();
}

class _PlantDiseaseDetailsState extends State<PlantDiseaseDetails> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Disease Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 500,
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: FileImage(widget.image))),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Detected Disease:",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                widget.diseaseDetxected,
                style: const TextStyle(
                    fontSize: 32, color: AppColors.primaryGreen),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                title: 'Fertilization Plan',
                lockIcon: userProvider.user!.isPremium ? false : true,
                onPress: () {
                  userProvider.user!.isPremium
                      ? Navigator.pushReplacementNamed(
                          context, '/plant_details_screen')
                      : Navigator.pushReplacementNamed(
                          context, '/payment_plan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
