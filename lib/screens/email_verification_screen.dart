import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawn_shot/core/constants/constants.dart';
import 'package:lawn_shot/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../providers/email_verification_provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<EmailVerificationProvider>(context, listen: false)
        .startEmailVerificationCheck(() {
      if (mounted) {
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please verify your email to continue',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.h),
            Consumer<EmailVerificationProvider>(
              builder: (context, provider, _) {
                return CustomButton(
                  onPress: provider.secondsRemaining <= 0
                      ? () {
                          provider.sendVerificationEmail();
                        }
                      : null,
                  color: provider.secondsRemaining <= 0
                      ? AppColors.primaryGreen
                      : AppColors.lightGrey,
                  title: provider.secondsRemaining <= 0
                      ? 'Send Verification Email'
                      : 'Wait ${provider.secondsRemaining} seconds',
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'Logout',
              color: AppColors.lightGrey,
              onPress: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
