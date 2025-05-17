import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<Dio> createDio() async {
  final dio = Dio();

  // if (!Hive.isBoxOpen('userdata')) {
  //   await Hive.openBox('userdata');
  // }

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ),
  );

  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       // Retrieve token before sending request
  //       options.headers.addAll({
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       });
  //       handler.next(options); // Continue with the request
  //     },
  //     onResponse: (response, handler) {
  //       handler.next(response);
  //     },
  //     onError: (DioException e, handler) async {
  //       if (e.response?.statusCode == 500) {
  //         // Token expired, refresh it
  //         log("Token expired, refreshing...");

  //         return;
  //       } else {
  //         handler.next(e);
  //       }
  //     },
  //   ),
  // );

  return dio;
}
