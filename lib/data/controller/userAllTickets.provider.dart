
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/config/network/api.state.dart';
import 'package:home/config/utils/preety.dio.dart';

final userAllTicketsProvider = FutureProvider((ref) async{
   final api = APIStateNetwork(await createDio());
   return await api.getAllTickets();
});