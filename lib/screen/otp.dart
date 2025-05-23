import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/config/auth/auth.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/controller/register.notifer.dart';
import 'package:home/data/model/register.body.validate.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

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

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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

  String? otp;
  void verifyOtp(String request_id) async {
    final userBody = ref.watch(userRegisterBodyProvider);
    String otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 6 && otp.runes.every((r) => r >= 48 && r <= 57)) {
      final data = RegisterBodyValidate(
        userMobile: "${userBody!.userMobile}",
        userFirstname: "${userBody!.userFirstname}",
        userLastname: "${userBody.userLastname}",
        ipAddress: "${userBody.ipAddress}",
        macAddress: "${userBody.ipAddress}",
        latitude: "${userBody.latitude}",
        longitude: "${userBody.longitude}",
        otpCheck: otp,
        requestId: request_id,
      );
      await AuthService().registerValidate(data);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter a valid 6-digit OTP")));
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpControllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 45,
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
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final userBody = ref.watch(userRegisterBodyProvider);
    final userBodyNotifier = ref.read(userRegisterBodyProvider.notifier);
    if (args is Map<String, dynamic>) {
      final requestId = args['@register_token'];
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Center(
                heightFactor: 1.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        'Verify OTP',
                        style: GoogleFonts.inter(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Please confirm the security code received\non your registered mobile number',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, _buildOtpBox),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '00:${_start.toString().padLeft(2, '0')} secs',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => verifyOtp(requestId),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 68, 128, 106),
                          minimumSize: Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap:
                            _isResendVisible
                                ? startTimer
                                : null, // Make retry clickable only when it's visible
                        child: Text.rich(
                          TextSpan(
                            text:
                                "Don't receive the OTP? ", // Regular text before "Retry"
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 14, // Color for the regular text
                            ),
                            children: [
                              TextSpan(
                                text: "Retry", // "Retry" text
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color:
                                      _isResendVisible
                                          ? Color.fromARGB(255, 68, 128, 106)
                                          : Colors
                                              .grey, // Green when visible, grey when not
                                  decoration:
                                      _isResendVisible
                                          ? TextDecoration.none
                                          : TextDecoration
                                              .none, // Underline when clickable
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
            ],
          ),
        ),
      );
    }
  }
}
