import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/data/model/login.body.model.dart';

class LoginBodyRequestNotifier extends StateNotifier<LoginBodyRequest> {
  LoginBodyRequestNotifier()
      : super(LoginBodyRequest(
          userMobile: '',
          ipAddress: '',
          macAddress: '',
          latitude: '',
          longitude: '',
        ));

  void setUserMobile(String value) {
    state = LoginBodyRequest(
      userMobile: value,
      ipAddress: state.ipAddress,
      macAddress: state.macAddress,
      latitude: state.latitude,
      longitude: state.longitude,
    );
  }

  void setIpAddress(String value) {
    state = LoginBodyRequest(
      userMobile: state.userMobile,
      ipAddress: value,
      macAddress: state.macAddress,
      latitude: state.latitude,
      longitude: state.longitude,
    );
  }

  void setMacAddress(String value) {
    state = LoginBodyRequest(
      userMobile: state.userMobile,
      ipAddress: state.ipAddress,
      macAddress: value,
      latitude: state.latitude,
      longitude: state.longitude,
    );
  }

  void setLatitude(String value) {
    state = LoginBodyRequest(
      userMobile: state.userMobile,
      ipAddress: state.ipAddress,
      macAddress: state.macAddress,
      latitude: value,
      longitude: state.longitude,
    );
  }

  void setLongitude(String value) {
    state = LoginBodyRequest(
      userMobile: state.userMobile,
      ipAddress: state.ipAddress,
      macAddress: state.macAddress,
      latitude: state.latitude,
      longitude: value,
    );
  }

  void reset() {
    state = LoginBodyRequest(
      userMobile: '',
      ipAddress: '',
      macAddress: '',
      latitude: '',
      longitude: '',
    );
  }
}


final loginBodyRequestProvider = StateNotifierProvider<LoginBodyRequestNotifier, LoginBodyRequest>(
  (ref) => LoginBodyRequestNotifier(),
);
