class LoginRequest {
  final int userMobile;
  final String userPassword;
  final String ipAddress;
  final String macAddress;
  final String latitude;
  final String longitude;

  LoginRequest({
    required this.userMobile,
    required this.userPassword,
    required this.ipAddress,
    required this.macAddress,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_mobile': userMobile,
      'user_password': userPassword,
      'ip_address': ipAddress,
      'mac_address': macAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
