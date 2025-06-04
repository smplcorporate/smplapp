import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/auth/auth.dart';
import 'package:home/data/controller/login.notider.dart';
import 'package:home/data/model/otpverfiy.model.dart';
import 'package:home/screen/home_page.dart';
import 'package:another_flushbar/flushbar.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  late Timer _timer;
  int _start = 30;
  bool _isResendVisible = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _start = 30;
      _isResendVisible = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendVisible = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  AuthService _authService = AuthService();
  void showTopMessage(String message, Color color) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 1),
      backgroundColor: color,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  bool _btnLoder = false;
  void verifyOtp(bool isLogin, String requestId) async {
    String otp = _otpControllers.map((c) => c.text).join();

    if (otp.length == 6 && otp.runes.every((r) => r >= 48 && r <= 57)) {
      setState(() {
        _btnLoder = true;
      });
      final userData = ref.watch(loginBodyRequestProvider);

      try {
        await _authService.loginalidate(
          VerfiyOtpBody(
            userMobile: userData.userMobile,
            ipAddress: userData.ipAddress,
            macAddress: userData.macAddress,
            latitude: userData.latitude,
            longitude: userData.longitude,
            otpCheck: otp,
            requestId: requestId,
          ),
          context,
        );
      } catch (e) {
        _btnLoder = false;
      }
    } else {
      showTopMessage("Enter a valid 6-digit OTP", Colors.red);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpBox(int index, double boxWidth, double fontSize) {
    return Container(
      width: boxWidth,
      height: boxWidth * 1.2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;
    final otpBoxSize = width * 0.11;
    final headingFont = 24 * scale;
    final normalFont = 15 * scale;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final token = args['@register_token'];
    final isLogin = args['@login'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30 * scale,
            vertical: 30 * scale,
          ),
          child: Column(
            children: [
              Text(
                'Verify OTP',
                style: GoogleFonts.inter(
                  fontSize: headingFont,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20 * scale),
              Text(
                'Please confirm the security code received\non your registered mobile number',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: normalFont,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30 * scale),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => _buildOtpBox(index, otpBoxSize, 18 * scale),
                ),
              ),
              SizedBox(height: 8 * scale),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '00:${_start.toString().padLeft(2, '0')} secs',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 12 * scale,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20 * scale),
              ElevatedButton(
                onPressed: () => verifyOtp(isLogin, token),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 128, 106),
                  minimumSize: Size(double.infinity, 48 * scale),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child:
                    _btnLoder == true
                        ? CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                        : Text(
                          'Confirm',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16 * scale,
                          ),
                        ),
              ),
              SizedBox(height: 20 * scale),
              GestureDetector(
                onTap: _isResendVisible ? startTimer : null,
                child: Text.rich(
                  TextSpan(
                    text: "Don't receive the OTP? ",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14 * scale,
                    ),
                    children: [
                      TextSpan(
                        text: "Resend",
                        style: GoogleFonts.inter(
                          fontSize: 14 * scale,
                          color:
                              _isResendVisible
                                  ? const Color.fromARGB(255, 68, 128, 106)
                                  : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
