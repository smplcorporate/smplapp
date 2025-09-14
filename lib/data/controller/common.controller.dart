import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/districtBody.req.dart';
import 'package:home/data/model/districtCommon.model.dart';
import 'package:home/data/model/stateCommon.model.dart';
import 'package:home/data/model/theshsilCommon.body.dart';
import 'package:home/data/model/theshsilCommon.model.dart';

final commonStateListProvider = FutureProvider<StateListCommon>((ref) async {
  final api = APIStateNetwork(await createDio());
  return api.getStateList();
});

final commonDistrictListProvider =
    FutureProvider.family<DistirctCommonModel, String>((ref, stateId) async {
      final api = APIStateNetwork(await createDio());
      return api.getDistrictList(
        DistrcBodyRequest(stateId: stateId.toString()),
      );
    });

final commonTehsilListProvider = FutureProvider.family<
  ThehSillCommonList,
  int
>((ref, body) async {
  final api = APIStateNetwork(await createDio());
  return api.getTehsilList(ThehSillCommonBody(districtId: body));
});
