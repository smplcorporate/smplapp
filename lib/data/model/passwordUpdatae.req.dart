class PasswordChangeRequest {
  String ipAddress;
  String passwordOld;
  String passwordNew;
  String passwordConfirm;

  PasswordChangeRequest({
    required this.ipAddress,
    required this.passwordOld,
    required this.passwordNew,
    required this.passwordConfirm,
  });

  Map<String, dynamic> toJson() {
    return {
      "ip_address": ipAddress,
      "password_old": passwordOld,
      "password_new": passwordNew,
      "password_confirm": passwordConfirm,
    };
  }
}
