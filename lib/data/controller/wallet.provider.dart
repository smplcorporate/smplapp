

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/getbankModel.dart';
import 'package:home/data/model/wallet.statementBody.dart';
import 'package:intl/intl.dart';
import 'package:retrofit/retrofit.dart';

final walletBalancePro0vider = FutureProvider((ref) async {
final state = APIStateNetwork(await createDio());
return state.getWallet();
});

final getWalleStatementProider = FutureProvider((ref) async {
final state = APIStateNetwork(await createDio());
return await state.getWalleStatement(WalletStateMentBody(dateFrom: "27-03-2025", dateTo: "${printFormattedDate()}", transId: ""));
});

final getWAlletPageLoadProvider = FutureProvider((ref) async {
final state = APIStateNetwork(await createDio());
return await state.getWalletPageLoad();
});

final getBakDetailProvider = FutureProvider.family<GetBankDetailModel, GetBankBodymodel>((ref, body) async {
  final state = APIStateNetwork(await createDio());
  return await state.fetchBankDetail(body);
});



String printFormattedDate() {
  DateTime now = DateTime.now(); // or any DateTime object
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  print(formattedDate);
  return formattedDate; // Output: 18-06-2025
}
