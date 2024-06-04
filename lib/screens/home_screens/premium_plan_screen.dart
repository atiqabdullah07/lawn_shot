import 'package:flutter/material.dart';
import 'package:lawn_shot/providers/auth_provider.dart';
import 'package:lawn_shot/providers/payment_provider.dart';
import 'package:lawn_shot/screens/home_screens/scan_screen.dart';
import 'package:lawn_shot/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constants.dart';

class PremiumPlanScreen extends StatefulWidget {
  const PremiumPlanScreen({super.key});

  @override
  State<PremiumPlanScreen> createState() => _PremiumPlanScreenState();
}

class _PremiumPlanScreenState extends State<PremiumPlanScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> benefits = [
      'More Fertilization Plans',
      'Lawn Guide',
      'All Lawn types',
      'Access to all the Pesticides Description'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Premium',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$ 5.99 / Month',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Subscribe to access more!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: benefits.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              const Icon(
                                Icons.fiber_manual_record,
                                color: AppColors.primaryGreen,
                                size: 8,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                benefits[index],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: CustomButton(
                            title: 'Try',
                            onPress: () async {
                              final message =
                                  await Provider.of<PaymentProvider>(context,
                                          listen: false)
                                      .makePayment('6');
                              if (message == 'Payment Successful!') {
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .updatePremiumStatus(true);
                              }
                              Future.delayed(const Duration(seconds: 0), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ScanScreen(),
                                    ));
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
