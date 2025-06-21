import 'dart:io';
import 'package:dio/dio.dart';
import 'package:home/config/utils/preety.dio.dart';

Future<void> submitAddWalletRequest({
  required String ipAddress,
  required String bankId,
  required String transAmount,
  required String transferType,
  required String bankReferenceId,
  required String depositDate,
  required String userMpin,
  required File imageFile,
}) async {
  final dio = await createDio();

  final url = 'https://uat.smplraj.in/b2c/appapi/request/b2c_wallet/addwallet_request_submit';

  final formData = FormData.fromMap({
    'ip_address': ipAddress,
    'bank_id': bankId,
    'trans_amount': transAmount,
    'transfer_type': transferType,
    'bank_reference_id': bankReferenceId,
    'deposit_date': depositDate,
    'user_mpin': userMpin,
    'image': await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.path.split('/').last,
    ),
  });

  try {
    final response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: {
          // Add necessary headers if required
          'Accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      print('Status: ${data['status']}');
      print('Message: ${data['status_desc']}');
      print('Transaction ID: ${data['trans_id']}');
    } else {
      print('Failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}
