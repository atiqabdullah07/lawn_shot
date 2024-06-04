import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

Future<void> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  try {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        //   pickedImage = File(pickedFile.path);
      });
      log('Image picked: ${pickedFile.path}');
    } else {
      log('No image picked.');
    }
  } catch (e) {
    log('Error picking image: $e');
  }
}

void setState(Null Function() param0) {}

class _ScanScreenState extends State<ScanScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanScreen'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              pickImage();
            },
            child: const Text("Click")),
      ),
    );
  }
}
