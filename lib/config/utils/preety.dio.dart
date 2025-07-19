import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<Dio> createDio() async {
  final dio = Dio();

  
  final box = Hive.box('userdata');
  final token = box.get('@token');

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve token before sending request
        options.headers.addAll({
          'Content-Type': 'application/json',
          'SMPL-B2CMAap-Encrypt-ID': 'c6715usrb4eeb2c97f4655bc2smpl740ecbe8abwin',
          'SMPL-B2CMApp-Encrypt-Passcode': 'wzrc6715user15u57f4655bc2wr200a426b2c10147857smpl45236wwin',
          if(token != null)
          'SMPL-B2CMApp-SESkey' : '$token'

          
        });
        log({
          'Content-Type': 'application/json',
          'SMPL-B2CMAap-Encrypt-ID': 'c6715usrb4eeb2c97f4655bc2smpl740ecbe8abwin',
          'SMPL-B2CMApp-Encrypt-Passcode': 'wzrc6715user15u57f4655bc2wr200a426b2c10147857smpl45236wwin',
          if(token != null)
          'SMPL-B2CMApp-SESkey' : '$token'

          
        }.toString());
        handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 500) {
          // Token expired, refresh it
          log("Token expired, refreshing...");

          return;
        } else {
          handler.next(e);
        }
      },
    ),
  );

  return dio;
}
