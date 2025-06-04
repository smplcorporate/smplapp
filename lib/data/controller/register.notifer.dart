import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/data/model/register.model1.dart';

class UserRegisterNotifier extends StateNotifier<UserRegisterBody?> {
  UserRegisterNotifier() : super(null);

  void setUserRegisterBody(UserRegisterBody body) {
    state = body;
  }

  void updateField({
    int? userMobile,
    String? userFirstname,
    String? userLastname,
    String? ipAddress,
    String? macAddress,
    String? latitude,
    String? longitude,
  }) {
    if (state == null) return;

    state = state!.copyWith(
      userMobile: userMobile,
      userFirstname: userFirstname,
      userLastname: userLastname,
      ipAddress: ipAddress,
      macAddress: macAddress,
      latitude: latitude,
      longitude: longitude,
    );
  }

  void clear() {
    state = null;
  }
}

final userRegisterBodyProvider =
    StateNotifierProvider<UserRegisterNotifier, UserRegisterBody?>(
  (ref) => UserRegisterNotifier(),
);

