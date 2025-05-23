
import 'package:dio/dio.dart';
import 'package:home/data/model/register.body.validate.dart';
import 'package:home/data/model/register.model1.dart';
import 'package:retrofit/retrofit.dart' hide Headers;

part 'api.state.g.dart';

@RestApi(baseUrl: 'https://uat.smplraj.in/b2c/appapi/')
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;
  @POST('outlet/b2c_register/initiate')
  Future<HttpResponse> registerUserInit(@Body() UserRegisterBody user);
  @POST('outlet/b2c_register/validate')
  Future<HttpResponse> registerUserValidate(@Body() RegisterBodyValidate userValidate);
}
