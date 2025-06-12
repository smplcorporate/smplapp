import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/config/utils/route.dart';
import 'package:home/data/model/login.body.model.dart';
import 'package:home/data/model/otpverfiy.model.dart';
import 'package:home/data/model/register.body.validate.dart';
import 'package:home/data/model/register.model1.dart';
import 'package:home/screen/home_page.dart';

class AuthService {
  OtpResponseRegister? _otpResponseRegister;
  RegisterResponseValidate? _registerResponseValidate;
  RegisterResponseValidate? get registerResponseValidate =>
      _registerResponseValidate;
  OtpResponseRegister? get otpResponseRegister => _otpResponseRegister;
  UserRegisterBody? _userRegisterBody;
  UserRegisterBody? get userRegisterBody => _userRegisterBody;
  LoginResponse? _loginResponse;
  LoginResponse? get loginResponse => _loginResponse;
  VerfiyOtpResponse? _verifyOtpResponse; // Corrected typo: verfiy -> verify
  VerfiyOtpResponse? get verifyOtpResponse =>
      _verifyOtpResponse; // Corrected typo: verfiy -> verify

  Future<void> registerInit(UserRegisterBody user, BuildContext context) async {
    final dio = await createDio();
    final service = APIStateNetwork(dio);
    final response = await service.registerUserInit(user);
    _userRegisterBody = user;
    try {
      print(
        "Raw response (registerInit): ${response.response.data}",
      ); // Debug response
      _otpResponseRegister = OtpResponseRegister.fromJson(
        response.response.data,
      );

      await Flushbar(
        message: 'OTP sent successfully',
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Colors.black87,
        flushbarPosition: FlushbarPosition.TOP,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        messageColor: Colors.white,
      ).show(context);

      navigatorKey.currentState?.pushNamed(
        '/otp',
        arguments: {
          '@register_token': _otpResponseRegister!.requestId,
          '@login': false,
        },
      );
    } catch (e) {
      print("Error in registerInit: $e"); // Debug error
      await Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> registerValidate(
    RegisterBodyValidate body,
    BuildContext context,
  ) async {
    final dio = await createDio();
    final service = APIStateNetwork(dio);
    final response = await service.registerUserValidate(body);

    try {
      print(
        "Raw response (registerValidate): ${response.response.data}",
      ); // Debug response
      _registerResponseValidate = RegisterResponseValidate.fromJson(
        response.response.data,
      );

      final box = Hive.box('userdata');
      if (_registerResponseValidate?.sessionToken != null) {
        await box.put('@token', _registerResponseValidate!.sessionToken);
        await box.put('@name', _registerResponseValidate!.userDetails.userName);
        await box.put(
          '@mobile',
          _registerResponseValidate!.userDetails.userMobile,
        );
      } else {
        print("Error: sessionToken is null in registerValidate");
        throw Exception("Session token is null");
      }

      await Flushbar(
        message: 'Registration successful',
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Colors.black87,
        flushbarPosition: FlushbarPosition.TOP,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        messageColor: Colors.white,
      ).show(context);

      // Use Navigator.push for consistency; alternatively, use named route: navigatorKey.currentState?.pushNamed('/home');
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print("Error in registerValidate: $e"); // Debug error
      await Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
      throw Exception("Something went wrong");
    }
  }

  Future<void> loginInit(LoginBodyRequest user, BuildContext context) async {
    final dio = await createDio();
    final service = APIStateNetwork(dio);
    final response = await service.login(user);
    if (response.response.data['status'] == false) {
      await Fluttertoast.showToast(
        msg: "${response.response.data['status']}",
        backgroundColor: Colors.red,
      );
    } else {
      try {
        print(
          "Raw response (loginInit): ${response.response.data}",
        ); // Debug response
        _loginResponse = LoginResponse.fromJson(response.response.data);

        await Flushbar(
          message: 'OTP sent to +91 ${user.userMobile}',
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(12),
          borderRadius: BorderRadius.circular(8),
          backgroundColor: Colors.black87,
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          messageColor: Colors.white,
        ).show(context);

        navigatorKey.currentState?.pushNamed(
          '/otp',
          arguments: {
            '@register_token': _loginResponse!.requestId,
            '@login': true,
          },
        );
      } catch (e) {
        print("Error in loginInit: $e"); // Debug error
        await Fluttertoast.showToast(
          msg: "Error: ${e.toString()}",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> loginValidate(VerfiyOtpBody body, BuildContext context) async {
    final dio = await createDio();
    final service = APIStateNetwork(dio);
    final response = await service.verfyiLogin(body);

    try {
      print(
        "Raw response (loginValidate): ${response.response.data}",
      ); // Debug response
      _verifyOtpResponse = VerfiyOtpResponse.fromJson(response.response.data);

      final box = Hive.box('userdata');
      if (_verifyOtpResponse?.sessionToken != null) {
        log("first save");
        await box.put('@token', _verifyOtpResponse!.sessionToken);
        await box.put('@name', _verifyOtpResponse!.userDetails.userName);
        await box.put('@mobile', _verifyOtpResponse!.userDetails.userMobile);
      } else {
        log("first save - 2");
        print("Error: sessionToken is null in loginValidate");
        throw Exception("Session token is null");
      }

      await Flushbar(
        message: "Login successful",
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.black,
        margin: const EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      log("first save - 3");
      // Use Navigator.push for consistency; alternatively, use named route: navigatorKey.currentState?.pushNamed('/home');
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      log("first save - 4");
      print("Error in loginValidate: $e"); // Debug error
      await Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
      throw Exception("OTP not verified");
    }
  }

  void clearData() {
    _otpResponseRegister = null;
    _registerResponseValidate = null;
    _loginResponse = null;
    _verifyOtpResponse = null;
  }
}
