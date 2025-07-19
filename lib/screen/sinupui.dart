import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/auth/auth.dart';
import 'package:home/data/controller/login.notider.dart';
import 'package:home/screen/loginwithPassword.pagae.dart';
import 'package:home/screen/otp.dart';
import 'package:home/screen/sincreate.dart';

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
  AuthService _auth = AuthService();

  void _createAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateAccountScreen()),
    );
  }

  void _submitMobile() async {
    String mobile = _mobileController.text.trim();
    RegExp mobileRegex = RegExp(r'^[0-9]{10}$');

    if (mobile.isEmpty) {
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
    } else if (!mobileRegex.hasMatch(mobile)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enter a valid 10-digit mobile number',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color.fromARGB(255, 149, 149, 149),
            ),
          ),
        ),
      );
    } else {
      setState(() {
        _btnLoder = true;
      });
      final userbody = ref.watch(loginBodyRequestProvider);
      // Flushbar(
      //   message: 'OTP sent to +91 $mobile',
      //   duration: const Duration(seconds: 2),
      //   margin: const EdgeInsets.all(12),
      //   borderRadius: BorderRadius.circular(8),
      //   backgroundColor: Colors.black87,
      //   flushbarPosition: FlushbarPosition.TOP,
      //   icon: const Icon(Icons.check_circle, color: Colors.white),
      //   messageColor: Colors.white,
      // ).show(context).then((_) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => VerifyOtpScreen()),
      //   );
      // });
      try{
        await _auth.loginInit(userbody, context);
      } catch (e){
        setState(() {
         _btnLoder = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final loginNotifier = ref.read(loginBodyRequestProvider.notifier);
      loginNotifier.setIpAddress("152.59.109.59");
      loginNotifier.setMacAddress("1not found");
      loginNotifier.setLatitude("26.917979");
      loginNotifier.setLongitude("75.814593");
    });
  }

  bool _btnLoder = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375; // Base scale factor for responsiveness

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Top-right image (success.png)
          Positioned(
            top: 50 * scale,
            right: -15 * scale,
            child: Image.asset(
              'assets/success3.png',
              width: 200 * scale,
              height: 80 * scale,
            ),
          ),

          // Decorative background circles
          Positioned(
            top: 250 * scale,
            left: -60 * scale,
            child: Container(
              height: 200 * scale,
              width: 200 * scale,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/circle1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 150 * scale,
            right: -60 * scale,
            child: Container(
              height: 180 * scale,
              width: 200 * scale,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/circle1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Fixed position for the aaplogin image (no scroll)
          Positioned(
            top: 130 * scale,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/aaplogin.png',
              height: screenHeight * 0.24,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 260 * scale,
                ), // Adjust for the fixed aaplogin image
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0 * scale),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40 * scale),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  offset: const Offset(0, 6),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: ClipPath(
                              clipper: HalfMoonClipper(),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 30 * scale,
                                  horizontal: 30 * scale,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Seamless Payments,\n Anytime!',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 24 * scale,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Recharge,send money,and make secure payments—just in a tap',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 13 * scale,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          30 * scale,
                                        ),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12 * scale,
                                        vertical: 6 * scale,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10 * scale,
                                            ),
                                            child: Text(
                                              '+91 ',
                                              style: GoogleFonts.inter(
                                                fontSize: 16 * scale,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: TextField(
                                              controller: _mobileController,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                  10,
                                                ),
                                              ],
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 10 * scale,
                                                    ),
                                                hintText:
                                                    'Enter your mobile number',
                                                hintStyle: GoogleFonts.inter(
                                                  fontSize: 14 * scale,
                                                  color: const Color.fromARGB(
                                                    255,
                                                    149,
                                                    149,
                                                    149,
                                                  ),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (value) {
                                                ref
                                                    .read(
                                                      loginBodyRequestProvider
                                                          .notifier,
                                                    )
                                                    .setUserMobile(value);
                                              },
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                255,
                                                68,
                                                128,
                                                106,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child:
                                                _btnLoder == false
                                                    ? IconButton(
                                                      icon: const Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: _submitMobile,
                                                    )
                                                    : CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20 * scale),
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
                                            fontSize: 14 * scale,
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
                                    SizedBox(height: 20 * scale),
                                    ElevatedButton(
                                      onPressed: _createAccount,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          68,
                                          128,
                                          106,
                                        ),
                                        minimumSize: Size(
                                          double.infinity,
                                          45 * scale,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30 * scale,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Create new account',
                                        style: GoogleFonts.inter(
                                          fontSize: 18 * scale,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) =>LoginWithPasswordScreen() ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          68,
                                          128,
                                          106,
                                        ),
                                        minimumSize: Size(
                                          double.infinity,
                                          45 * scale,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30 * scale,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'login with password',
                                        style: GoogleFonts.inter(
                                          fontSize: 18 * scale,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 25 * scale),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            'By Continuing, you agree to our ',
                                        children: [
                                          TextSpan(
                                            text: 'Terms of Services',
                                            style: GoogleFonts.inter(
                                              fontSize: 12 * scale,
                                              color: Color.fromARGB(
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HalfMoonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 80);
    path.quadraticBezierTo(size.width / 2, -90, size.width, 90);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
