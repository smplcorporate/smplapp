import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/auth/auth.dart';
import 'package:home/data/controller/login.notider.dart';
import 'package:home/data/model/login.body.model.dart';
import 'package:home/screen/otp.dart';
import 'package:home/screen/sincreate.dart'; // Your signup screen

// Your main App entry point
class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final TextEditingController _mobileController = TextEditingController();
  bool btnLoder = false;
  final _authService = AuthService();
  // Navigate to sign-up screen when button is clicked
  void _createAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAccountScreen(),
      ), // This is your CreateAccountScreen
    );
  }

  // Submit mobile and navigate to the next screen (e.g., OTP screen)
  void _submitMobile() async {
    if (_mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your mobile number',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color.fromARGB(255, 149, 149, 149),
            ),
          ),
        ),
      );
    } else {
      setState(() {
        btnLoder = false;
      });
      final loginNotifier = ref.read(loginBodyRequestProvider.notifier);

      loginNotifier.setIpAddress("127.0.0.1");
      loginNotifier.setLatitude("26.917979");
      loginNotifier.setLongitude("75.814593");
      loginNotifier.setMacAddress("not found");
      loginNotifier.setUserMobile(_mobileController.text);
      try {
        await _authService.loginInit(
          LoginBodyRequest(
            userMobile: _mobileController.text,
            ipAddress: "127.0.0.1",
            macAddress: "not found",
            latitude: "26.917979",
            longitude: "75.814593",
          ),
        );
      } catch (e) {
        setState(() {
          btnLoder = false;
        });
      }

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('OTP sent to ${_mobileController.text}')),
      // );

      // Add navigation to the next screen, for example, OTP screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Left decorative circle image
          Positioned(
            top: 250,
            left: -60,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/circle1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Right decorative circle image
          Positioned(
            top: 120,
            right: -60,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/circle1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Image.asset('assets/aaplogin.png', height: 350),

                  // Half-moon with shadow and content
                  Stack(
                    children: [
                      // Shadow container
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 600,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                spreadRadius: 5,
                                blurRadius: 30,
                                offset: const Offset(0, -20),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Main half-moon container
                      ClipPath(
                        clipper: HalfMoonClipper(),
                        child: Container(
                          width: double.infinity,
                          height: 600,
                          padding: const EdgeInsets.symmetric(
                            vertical: 65,
                            horizontal: 30,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Seamless Payments,\n Anytime!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Recharge, send money, and make secure payments\n—just in a tap',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed:
                                    _createAccount, // Navigate to SignUp screen
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    68,
                                    128,
                                    106,
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'Create new account',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),

                              // OR with dividers
                              Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                      endIndent: 10,
                                    ),
                                  ),
                                  Text(
                                    'OR',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                      indent: 10,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30),

                              // Mobile input with circular button
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        '91+ ',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        controller: _mobileController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your mobile number',
                                          hintStyle: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: const Color.fromARGB(
                                              255,
                                              149,
                                              149,
                                              149,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                            255,
                                            68,
                                            128,
                                            106,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                          onPressed:
                                              _submitMobile, // Navigate on mobile submit
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Terms text
                              Text.rich(
                                TextSpan(
                                  text: 'By Continuing, you agree to our ',
                                  children: [
                                    TextSpan(
                                      text: 'Terms of Services',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: const Color.fromARGB(
                                          255,
                                          68,
                                          128,
                                          106,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🌙 Custom clipper for half-moon shape
class HalfMoonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 90);
    path.quadraticBezierTo(size.width / 2, -90, size.width, 90);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
