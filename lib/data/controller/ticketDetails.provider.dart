

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';
import 'package:home/data/model/ticketModel.req.dart';

final ticketDetailsProvider = FutureProvider.family((ref, String ticketId) async {
  final api = APIStateNetwork(await createDio());
  final response = await api.getTicketDetails(
    TicketDetailsRequest(ticketId: ticketId),
  );
  return response;
});