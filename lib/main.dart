import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawn_shot/providers/auth_provider.dart';
import 'package:lawn_shot/providers/home_provider.dart';
import 'package:lawn_shot/routes/routes.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            title: 'App Name',
            initialRoute: AppRoutes.login,
            routes: AppRoutes.routes,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
              textTheme: GoogleFonts.lexendTextTheme(),
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.blue,
            ),
          );
        });
  }
}
