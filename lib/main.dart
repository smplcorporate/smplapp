import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:home/config/utils/route.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/otp.dart';
import 'package:home/screen/splashscreen.dart';

// ✅ Import splash screen

void main() async {
  // Ensures all Flutter bindings are initialized before any other code runs.
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Hive.initFlutter();
    if (!Hive.isBoxOpen('userdata')) {
      await Hive.openBox('userdata');
    }
  } catch (e) {
    log("Hive initialization failed: $e");
  }

  // Initializes time zones for working with time zone-specific notifications.

  // Run the app after initializing.
    runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box("userdata");
    final token = box.get("@token");
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Bank Aap',
          theme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          routes: {
            '/otp': (context) => VerifyOtpScreen(),
            '/home': (context) => HomePage(),
          },
          home: token ==null? PaymentIntroScreen() : HomePage(), 
        );
      },
    );
  }
}
