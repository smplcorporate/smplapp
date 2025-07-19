import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/data/model/billerParam.model.dart';

class ParamsNotifier extends StateNotifier<ParamsState> {
  ParamsNotifier()
      : super(ParamsState(
          param1: '',
          param2: '',
          param3: '',
          param4: '',
          param5: '',
        ));

  void updateParam1(String value) {
    state = state.copyWith(param1: value);
  }

  void updateParam2(String value) {
    state = state.copyWith(param2: value);
  }

  void updateParam3(String value) {
    state = state.copyWith(param3: value);
  }

  void updateParam4(String value) {
    state = state.copyWith(param4: value);
  }

  void updateParam5(String value) {
    state = state.copyWith(param5: value);
  }

  void clearData(){
    log("data cleard");
    state = ParamsState(
          param1: '',
          param2: '',
          param3: '',
          param4: '',
          param5: '',
        );
  }
}
final paramsProvider = StateNotifierProvider<ParamsNotifier, ParamsState>(
  (ref) => ParamsNotifier(),
);
