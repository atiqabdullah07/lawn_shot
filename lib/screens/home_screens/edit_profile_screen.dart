import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawn_shot/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custom_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    _userNameController.text = userProvider.user?.userName ?? '';

    Future<void> pickImage() async {
      final ImagePicker _picker = ImagePicker();
      try {
        final XFile? pickedFile =
            await _picker.pickImage(source: ImageSource.camera);
        print("Picked File: $pickedFile");

        if (pickedFile != null) {
          setState(() {
            userProvider.pickedImage = File(pickedFile.path);
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await pickImage();
                    String url = await userProvider
                        .uploadPicture(userProvider.pickedImage!);
                    await userProvider.updateProfilePicture(url);
                    Navigator.pop(context);
                  },
                  child: Consumer<UserProvider>(
                    builder: (_, provider, child) {
                      return provider.user?.pfp != ''
                          ? CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                provider.user!.pfp,
                              ),
                              radius: 75.r,
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: const AssetImage(
                                'assets/defaultpic.jpg',
                              ),
                              radius: 75.r,
                            );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Username',
                      controller: _userNameController,
                      obsecureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Username';
                        } else if (value == userProvider.user?.userName) {
                          return 'Choose a different username than your current';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
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
                ),
              ),
              CustomButton(
                  title: 'Save',
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      await userProvider
                          .updateUserName(_userNameController.text);
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
