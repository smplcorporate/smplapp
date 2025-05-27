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

  Future<void> loginInit(LoginBodyRequest user) async {
    final dio = await createDio();
    final service = APIStateNetwork(dio);
    final response = await service.login(user);

    try {
      _loginResponse = LoginResponse.fromJson(response.response.data);
      Fluttertoast.showToast(
        msg: "OTP sent successfully",
        backgroundColor: Colors.green,
      );
      navigatorKey.currentState?.pushNamed(
        '/otp',
        arguments: {
          '@register_token': _otpResponseRegister!.requestId,
          '@login': true,
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> loginalidate(VerfiyOtpBody body) async {
    final dio = await createDio();

    final service = APIStateNetwork(dio);
    final response = await service.verfyiLogin(body);

    try {
      _verfiyOtpResponse = VerfiyOtpResponse.fromJson(response.response.data);
      final box = Hive.box('userdata');
      await box.put('@token', _registerResponseValidate!.sessionToken);
      await box.put('@name', _registerResponseValidate!.userDetails.userName);
      await box.put(
        '@mobile',
        _registerResponseValidate!.userDetails.userMobile,
      );

      Fluttertoast.showToast(
        msg: "Login successful",
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

  void clearData() {
    _otpResponseRegister = null;
    _registerResponseValidate = null;
  }
}
