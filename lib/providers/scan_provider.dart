import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScanProvider with ChangeNotifier {
  File? pickedImage;
  // String detectedDisease = '';

  Future<String> uploadPicture(File image) async {
    try {
      final imgId = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref('Profile Pics');
      final imgRef = storageRef.child('path_$imgId');

      await imgRef.putFile(image);

      final url = await imgRef.getDownloadURL();

      return url;
    } catch (e) {
      if (e is FirebaseException) {
        log('Firebase Storage Error: ${e.code}');
        log('Firebase Storage Error Message: ${e.message}');
      } else {
        log('Error uploading or getting download URL: $e');
        // Handle other types of errors if needed.
      }

      return ''; // Return a default value on failure
    }
  }

  Future<String> detectPlantDisease({required imageUrl}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://plant-disease-flask-e297b2e00068.herokuapp.com/url'));
      request.body = json.encode({"url": imageUrl});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(res);
        String detectedDisease = responseData['Detected_disease'].toString();
        return detectedDisease;
      } else {
        log(response.reasonPhrase.toString());
        return '';
      }
    } catch (error) {
      log('detectPlantDisease Catched Error: $error');
      return 'Error';
    }
  }

  Future<String> detectLawnType({required imageUrl}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://detect-grass-docker-flask-app-b6f0ffb997bc.herokuapp.com/predict'));
      request.body = json.encode({"url": imageUrl});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        log(res.toString());
        Map<String, dynamic> responseData = jsonDecode(res);
        String detectedType = responseData['grass_type'].toString();
        return detectedType;
      } else {
        print(response.reasonPhrase);
        return response.reasonPhrase!;
      }
    } catch (error) {
      log('detectLawnType Catched Error: $error');
      return 'Error';
    }
  }
}
