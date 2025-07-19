

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/order.details.body.dart';
import 'package:home/data/model/orderDetails.res.dart';

final orderDetailsProvider = FutureProvider.family<OrderDetailsRes, String>((ref, id)async {
final state = APIStateNetwork(await createDio());
return state.getOrderDetails(GetOrderDetailsBody(transId: id));
});