import 'package:another_flushbar/flushbar.dart';
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

class AuthService {
  OtpResponseRegister? _otpResponseRegister;
  RegisterResponseValidate? _registerResponseValidate;
  RegisterResponseValidate? get registerResponseValidate =>
      _registerResponseValidate;
  OtpResponseRegister? get otpResponseRegister => _otpResponseRegister;
  UserRegisterBody? _userRegisterBody;
  UserRegisterBody? get userRegisterBody => _userRegisterBody;
  LoginResponse? _loginResponse;
  LoginResponse? get loginresponse => _loginResponse;
  VerfiyOtpResponse? _verfiyOtpResponse;
  VerfiyOtpResponse? get verfiyOtpResponse => _verfiyOtpResponse;

  Future<void> regiterInit(UserRegisterBody user) async {
    final dio = await createDio();
    final service = APIStateNetwork(dio);
    final response = await service.registerUserInit(user);
    _userRegisterBody = user;
    try {
      _otpResponseRegister = OtpResponseRegister.fromJson(
        response.response.data,
      );
      Fluttertoast.showToast(
        msg: "OTP sent successfully",
        backgroundColor: Colors.green,
      );
      navigatorKey.currentState?.pushNamed(
        '/otp',
        arguments: {
          '@register_token': _otpResponseRegister!.requestId,
          '@login': false,
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> registerValidate(RegisterBodyValidate body) async {
    final dio = await createDio();

    final service = APIStateNetwork(dio);
    final response = await service.registerUserValidate(body);

    try {
      _registerResponseValidate = RegisterResponseValidate.fromJson(
        response.response.data,
      );
      final box = Hive.box('userdata');
      await box.put('@token', _registerResponseValidate!.sessionToken);
      await box.put('@name', _registerResponseValidate!.userDetails.userName);
      await box.put(
        '@mobile',
        _registerResponseValidate!.userDetails.userMobile,
      );

      Fluttertoast.showToast(
        msg: "Registration successful",
        backgroundColor: Colors.green,
      );
      navigatorKey.currentState?.pushNamed('/home');
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> loginInit(LoginBodyRequest user, context) async {
    final dio = await createDio();
    final service = APIStateNetwork(dio);
    final response = await service.login(user);
    if (response.response.data['status'] == false) {
      Fluttertoast.showToast(
        msg: "${response.response.data['status']}",
        backgroundColor: Colors.red,
      );
    } else {
      try {
        _loginResponse = LoginResponse.fromJson(response.response.data);
        // Fluttertoast.showToast(
        //   msg: "OTP sent successfully",
        //   backgroundColor: Colors.green,
        // );
        Flushbar(
          message: 'OTP sent to +91 ${user.userMobile}',
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(12),
          borderRadius: BorderRadius.circular(8),
          backgroundColor: Colors.black87,
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          messageColor: Colors.white,
        ).show(context).then((_) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => VerifyOtpScreen()),
          // );
          navigatorKey.currentState?.pushNamed(
            '/otp',
            arguments: {
              '@register_token': _loginResponse!.requestId,
              '@login': true,
            },
          );
        });
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error: ${e.toString()}",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> loginalidate(VerfiyOtpBody body, context) async {
    final dio = await createDio();

    final service = APIStateNetwork(dio);
    final response = await service.verfyiLogin(body);

    try {
      _verfiyOtpResponse = VerfiyOtpResponse.fromJson(response.response.data);
      final box = Hive.box('userdata');
      await box.put('@token', _verfiyOtpResponse!.sessionToken);
      await box.put('@name', _verfiyOtpResponse!.userDetails.userName);
      await box.put('@mobile', _verfiyOtpResponse!.userDetails.userMobile);
      Flushbar(
        message: "Login successful",
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.black,
        margin: const EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      navigatorKey.currentState?.pushNamed('/home');
    } catch (e) {
      
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
      throw Exception("Otp not vefiye");
    }
  }

  void clearData() {
    _otpResponseRegister = null;
    _registerResponseValidate = null;
  }
}
