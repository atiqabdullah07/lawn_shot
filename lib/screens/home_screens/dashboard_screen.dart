import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawn_shot/core/constants/constants.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww'),
            ),
            const SizedBox(
              width: 12,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shane',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'Gardner',
                  style: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.menu,
              size: 32.r,
              color: Colors.grey.shade400,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Diseases",
                style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2 / 2,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      "https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=eYADMQ9dXTz1mggdfn_exN2gY61aH4fJz1lfMomv6o4=",
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Diseases",
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
