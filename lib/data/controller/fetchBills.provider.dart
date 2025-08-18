import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/billerParms.model.dart';
import 'package:home/data/model/billerParms.req.model.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/fetchBiller.res.model.dart';


final fetchBillDataProvider = FutureProvider.family<FetchResponseModel, FetchBodymodel>((ref, body) async {
  final service = APIStateNetwork(await createDio());
  final data = await service.ferchBill(
    body.path,
    body.data,
  );
  return data.data;
});

final fetchBillerParamProvider = FutureProvider.family<BillerParamResponse, FetchBllerParam>((ref, body) async {
  final state = APIStateNetwork(await createDio());
  return state.fetchBillerParm(body.path, body.data);
});

final fetchBillerParamProvider2 = FutureProvider.family<BillerParamResponse, FetchBllerParam>((ref, body) async {
  final state = APIStateNetwork(await createDio());
  return state.dthBillerParm(body.path, body.data);
});


class FetchBodymodel{
  final String path;
  final FetchBillModel data;

  FetchBodymodel({required this.path, required this.data});

}

class FetchBllerParam{
  final String path;
  final BillerParamRequest data;

  FetchBllerParam({required this.path, required this.data});

}