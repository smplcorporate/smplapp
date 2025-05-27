import 'package:dio/dio.dart';
import 'package:home/data/model/electritysityModel.dart';
import 'package:home/data/model/login.body.model.dart';
import 'package:home/data/model/otpverfiy.model.dart';
import 'package:home/data/model/register.body.validate.dart';
import 'package:home/data/model/register.model1.dart';
import 'package:retrofit/retrofit.dart' hide Headers;

part 'api.state.g.dart';

@RestApi(baseUrl: 'https://uat.smplraj.in/b2c/appapi/')
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;
  //Regsiter API
  @POST('outlet/b2c_register/initiate')
  Future<HttpResponse> registerUserInit(@Body() UserRegisterBody user);
  @POST('outlet/b2c_register/validate')
  Future<HttpResponse> registerUserValidate(
    @Body() RegisterBodyValidate userValidate,
  );
  // get billers
  @POST('bbps/b2c_bills_electricity/get_billers')
  Future<HttpResponse<ElectricityModel>> getElectritcity(
    @Body() ElectricityBody body,
  );
  // Login api
  @POST('outlet/b2c_login/otp_initiate')
  Future<HttpResponse<LoginResponse>> login(@Body() LoginBodyRequest body);
  @POST('outlet/b2c_login/otp_validate')
  Future<HttpResponse<VerfiyOtpResponse>> verfyiLogin(@Body() VerfiyOtpBody body);

}
