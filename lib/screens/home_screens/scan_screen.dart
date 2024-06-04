// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import 'package:lawn_shot/providers/scan_provider.dart';
import 'package:lawn_shot/screens/lawn_type_detector.dart';
import 'package:lawn_shot/screens/plant_disease.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    Future<void> pickImage() async {
      final ImagePicker _picker = ImagePicker();
      try {
        final XFile? pickedFile =
            await _picker.pickImage(source: ImageSource.camera);
        print("Picked File: $pickedFile");

        if (pickedFile != null) {
          setState(() {
            scanProvider.pickedImage = File(pickedFile.path);
          });
          log('Image picked: ${pickedFile.path}');
        } else {
          log('No image picked.');
        }
      } catch (e) {
        log('Error picking image: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            scanOptions(
              title: 'Plant Disease Detector',
              imageUrl:
                  'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=eYADMQ9dXTz1mggdfn_exN2gY61aH4fJz1lfMomv6o4=',
              onTap: () async {
                easyLoading();
                await pickImage();

                String imageUrl =
                    await scanProvider.uploadPicture(scanProvider.pickedImage!);

                String diseaseName =
                    await scanProvider.detectPlantDisease(imageUrl: imageUrl);
                EasyLoading.dismiss();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantDiseaseDetails(
                      image: scanProvider.pickedImage!,
                      diseaseDetxected: diseaseName,
                    ),
                  ),
                );
              },
            ),
            scanOptions(
                title: 'Lawn Detector',
                onTap: () async {
                  easyLoading();
                  await pickImage();

                  String imageUrl = await scanProvider
                      .uploadPicture(scanProvider.pickedImage!);

                  String typeName =
                      await scanProvider.detectLawnType(imageUrl: imageUrl);
                  EasyLoading.dismiss();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LawnTypeDetectorScreen(
                        image: scanProvider.pickedImage!,
                        typeDetxected: typeName,
                      ),
                    ),
                  );
                },
                imageUrl:
                    'https://static8.depositphotos.com/1008280/1044/i/450/depositphotos_10447636-stock-photo-grass-field.jpg')
          ],
        ),
      ),
    );
  }

  GestureDetector scanOptions(
      {required String title,
      required String imageUrl,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          height: 100,
          width: 1.sw,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ], borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imageUrl)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
