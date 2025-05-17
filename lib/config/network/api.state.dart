
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' hide Headers;

part 'api.state.g.dart';

@RestApi(baseUrl: 'https://uat.smplraj.in/b2c/appapi/')
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;


}
