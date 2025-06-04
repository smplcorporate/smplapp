class UserRegisterBody {
  final int userMobile;
  final String userFirstname;
  final String userLastname;
  final String ipAddress;
  final String macAddress;
  final String latitude;
  final String longitude;

  UserRegisterBody({
    required this.userMobile,
    required this.userFirstname,
    required this.userLastname,
    required this.ipAddress,
    required this.macAddress,
    required this.latitude,
    required this.longitude,
  });

  factory UserRegisterBody.fromJson(Map<String, dynamic> json) {
    return UserRegisterBody(
      userMobile: json['user_mobile'],
      userFirstname: json['user_firstname'],
      userLastname: json['user_lastname'],
      ipAddress: json['ip_address'],
      macAddress: json['mac_address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_mobile': userMobile,
      'user_firstname': userFirstname,
      'user_lastname': userLastname,
      'ip_address': ipAddress,
      'mac_address': macAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  UserRegisterBody copyWith({
    int? userMobile,
    String? userFirstname,
    String? userLastname,
    String? ipAddress,
    String? macAddress,
    String? latitude,
    String? longitude,
  }) {
    return UserRegisterBody(
      userMobile: userMobile ?? this.userMobile,
      userFirstname: userFirstname ?? this.userFirstname,
      userLastname: userLastname ?? this.userLastname,
      ipAddress: ipAddress ?? this.ipAddress,
      macAddress: macAddress ?? this.macAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

class OtpResponseRegister {
  final bool status;
  final String statusDesc;
  final String requestId;
  final int validSeconds;

  OtpResponseRegister({
    required this.status,
    required this.statusDesc,
    required this.requestId,
    required this.validSeconds,
  });

  factory OtpResponseRegister.fromJson(Map<String, dynamic> json) {
    return OtpResponseRegister(
      status: json['status'],
      statusDesc: json['status_desc'],
      requestId: json['request_id'],
      validSeconds: json['valid_seconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'status_desc': statusDesc,
      'request_id': requestId,
      'valid_seconds': validSeconds,
    };
  }
}
