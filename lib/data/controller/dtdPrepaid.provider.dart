import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/dthPrepaid.res.dart';
import 'package:home/data/model/electritysityModel.dart';

final dthPrepaidProvider = FutureProvider<DthPrepaidResponse>((ref) async {
  final service = APIStateNetwork(await createDio());
  final data = await service.getDTHPrepaidBillers(
    ElectricityBody(
      ipAddress: "152.59.109.59",
      macAddress:  "not found",
      latitude: "26.917979",
      longitude: "75.814593",
    ),
  );
  return data.data;
});
