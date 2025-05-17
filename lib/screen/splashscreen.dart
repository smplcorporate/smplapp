import 'package:flutter/material.dart';
import 'package:home/screen/home_page.dart';
import 'dart:async';
import 'openaccount.dart'; // Your main screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key})
  ;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to main screen after 3 seconds
    Timer(const Duration(seconds:4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) =>  HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 243, 235),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // You can replace this with your app logo
            Image.asset(
              'assets/ps.png',
           height: MediaQuery.of(context).size.height * 0.3, // 20% of screen height
  width: MediaQuery.of(context).size.width * 0.4,  
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to BankApp',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
