import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/data/model/mobilePrepaid.res.dart';

// BillerState class with proper equality
class BillerState {
  final BillersList? selectedBiller;
  final CircleList? selectedCircle;
  final String? number;

  BillerState({this.selectedBiller, this.selectedCircle, this.number});

  BillerState copyWith({
    BillersList? selectedBiller,
    CircleList? selectedCircle,
    String? number,
  }) {
    return BillerState(
      selectedBiller: selectedBiller ?? this.selectedBiller,
      selectedCircle: selectedCircle ?? this.selectedCircle,
      number: number ?? this.number,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillerState &&
          runtimeType == other.runtimeType &&
          selectedBiller == other.selectedBiller &&
          selectedCircle == other.selectedCircle &&
          number == other.number;

  @override
  int get hashCode =>
      selectedBiller.hashCode ^ selectedCircle.hashCode ^ number.hashCode;
}

// BillerNotifier (updated to handle number)
class BillerNotifier extends StateNotifier<BillerState> {
  BillerNotifier() : super(BillerState());

  void setBiller(BillersList biller) {
    state = state.copyWith(selectedBiller: biller, selectedCircle: null);
  }

  void setCircle(CircleList circle) {
    state = state.copyWith(selectedCircle: circle);
  }

  void setNumber(String number) {
    state = state.copyWith(number: number);
  }

  void reset() {
    state = BillerState();
  }
}

final billerProvider = StateNotifierProvider<BillerNotifier, BillerState>((ref) {
  return BillerNotifier();
});