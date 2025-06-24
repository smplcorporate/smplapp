

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/mobileplanRes.model.dart';

final mobilePlanProvider = FutureProvider.family<MobilePlansResponseModel, RechargeRequestModel>((ref, body)async {
  final state = APIStateNetwork(await createDio());
  return  state.fetchMobilePlan(body);
});