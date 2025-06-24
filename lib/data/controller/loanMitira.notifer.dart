import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/data/model/lonMitra.model.dart';

class LoanmitraFormNotifier extends StateNotifier<LoanmitraFormModel> {
  LoanmitraFormNotifier() : super(LoanmitraFormModel());

  void updateField(String field, dynamic value) {
    switch (field) {
      case 'ipAddress':
        state = state.copyWith(ipAddress: value);
        break;
      case 'macAddress':
        state = state.copyWith(macAddress: value);
        break;
      case 'latitude':
        state = state.copyWith(latitude: value);
        break;
      case 'longitude':
        state = state.copyWith(longitude: value);
        break;
      case 'serviceType':
        state = state.copyWith(serviceType: value);
        break;
      case 'serviceProviderCode':
        state = state.copyWith(serviceProviderCode: value);
        break;
      case 'customerName':
        state = state.copyWith(customerName: value);
        break;
      case 'customerMobile':
        state = state.copyWith(customerMobile: value);
        break;
      case 'customerEmail':
        state = state.copyWith(customerEmail: value);
        break;
      case 'customerDob':
        state = state.copyWith(customerDob: value);
        break;
      case 'customerMonthlyIncome':
        state = state.copyWith(customerMonthlyIncome: value);
        break;
      case 'customerAddress':
        state = state.copyWith(customerAddress: value);
        break;
      case 'aadhaarNo':
        state = state.copyWith(aadhaarNo: value);
        break;
      case 'panNo':
        state = state.copyWith(panNo: value);
        break;
      case 'aadhaarNoFile':
        state = state.copyWith(aadhaarNoFile: value);
        break;
      case 'panNoFile':
        state = state.copyWith(panNoFile: value);
        break;
      case 'userMpin':
        state = state.copyWith(userMpin: value);
        break;
    }
  }

  void resetForm() {
    state = LoanmitraFormModel();
  }
}


final loanmitraFormProvider = StateNotifierProvider<LoanmitraFormNotifier, LoanmitraFormModel>(
  (ref) => LoanmitraFormNotifier(),
);
