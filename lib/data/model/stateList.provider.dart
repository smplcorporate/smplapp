
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/districtBody.req.dart';
import 'package:home/data/model/distrubiterBody.req.dart';
import 'package:home/data/model/distubiterBody.res.dart';

final stateProvider = FutureProvider((ref) async {
  final api = APIStateNetwork(await createDio());
  return await api.getAllLPgState();
});

final getDistrictListProvider = FutureProvider.family((ref, stateID) async {
  final api = APIStateNetwork(await createDio());
  return await api.getDistrct(DistrcBodyRequest(stateId: stateID.toString()));
});

final getDistrubterProvider = FutureProvider.family<DistrubuterBodyRes, Map<String, dynamic>>((ref, body)async {
  final api = APIStateNetwork(await createDio());
  return await api.fetchDistrubter(DistrubuterBodyReq(
    stateId: body['stateID'],
    districtId: body['districtId']
  ));
});

