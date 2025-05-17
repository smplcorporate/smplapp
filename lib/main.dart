import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:home/creditap1.dart';
import 'package:home/creditappl2.dart';
import 'package:home/crideitapl3.dart';
import 'package:home/myprofile.dart';
import 'package:home/profile.dart';
import 'package:home/rechargeorbillpayment.dart';
import 'package:home/screen/dth1.dart';
import 'package:home/rechargebill.dart';
import 'package:home/rechargebill2.dart';
import 'package:home/rechargebill3.dart';
import 'package:home/screen/biller.dart';
import 'package:home/screen/dth2.dart';
import 'package:home/screen/dth3.dart';
import 'package:home/screen/elebillsummary.dart';
import 'package:home/screen/eletercitybill.dart';
import 'package:home/screen/gasno.dart';
import 'package:home/screen/home_page.dart';
import 'package:home/screen/lender2.dart';
import 'package:home/screen/lic%20insurance.dart';
import 'package:home/screen/loanservice.dart';
import 'package:home/screen/muthootfin2.dart';
import 'package:home/screen/muthoothfin.dart';
import 'package:home/screen/notification2.dart';
import 'package:home/screen/contact.dart';
import 'package:home/screen/openaccount.dart';
import 'package:home/screen/payment.dart';
import 'package:home/screen/screen2.dart';
import 'package:home/screen/selectgas.dart';
import 'package:home/screen/smartloan.dart';
import 'package:home/screen/success.dart';
import 'package:home/screen/wallet.dart';
import 'package:home/screen/splashscreen.dart';
import 'package:home/sendamount.dart'; // ✅ Import splash screen

void main() async {
  // Ensures all Flutter bindings are initialized before any other code runs.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initializes time zones for working with time zone-specific notifications.

  // Run the app after initializing.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bank Aap',
          theme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          home: ChatScreen
          (), // ✅ Start from splash screen
        );
      },
    );
  }
}
