

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';

final kycProvider = FutureProvider((ref) async {
final state = APIStateNetwork(await createDio());
return await state.fetchKycList();
});