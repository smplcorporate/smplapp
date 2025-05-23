import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/config/utils/route.dart';
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
        arguments: {'@register_token': _otpResponseRegister!.requestId},
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
      await box.put('@name', _registerResponseValidate!.userDetails[0].name);
      await box.put(
        '@mobile',
        _registerResponseValidate!.userDetails[0].mobile,
      );
      await box.put('@blance', _registerResponseValidate!.userBalance);
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

  void clearData() {
    _otpResponseRegister = null;
    _registerResponseValidate = null;
  }
}
