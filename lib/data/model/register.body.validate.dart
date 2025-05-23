class RegisterBodyValidate {
  final String userMobile;
  final String userFirstname;
  final String userLastname;
  final String ipAddress;
  final String macAddress;
  final String latitude;
  final String longitude;
  final String otpCheck;
  final String requestId;

  RegisterBodyValidate({
    required this.userMobile,
    required this.userFirstname,
    required this.userLastname,
    required this.ipAddress,
    required this.macAddress,
    required this.latitude,
    required this.longitude,
    required this.otpCheck,
    required this.requestId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_mobile': userMobile,
      'user_firstname': userFirstname,
      'user_lastname': userLastname,
      'ip_address': ipAddress,
      'mac_address': macAddress,
      'latitude': latitude,
      'longitude': longitude,
      'otp_check': otpCheck,
      'request_id': requestId,
    };
  }
}


class RegisterResponseValidate {
  final bool status;
  final String statusDesc;
  final List<UserDetail> userDetails;
  final List<UserBalance> userBalance;
  final String sessionToken;

  RegisterResponseValidate({
    required this.status,
    required this.statusDesc,
    required this.userDetails,
    required this.userBalance,
    required this.sessionToken,
  });

  factory RegisterResponseValidate.fromJson(Map<String, dynamic> json) {
    return RegisterResponseValidate(
      status: json['status'],
      statusDesc: json['status_desc'],
      userDetails: (json['user_details'] as List)
          .map((e) => UserDetail.fromJson(e))
          .toList(),
      userBalance: (json['user_balance'] as List)
          .map((e) => UserBalance.fromJson(e))
          .toList(),
      sessionToken: json['session_token'],
    );
  }
}

class UserDetail {
  final String id;
  final String mobile;
  final String name;
  final String kycStatus;

  UserDetail({
    required this.id,
    required this.mobile,
    required this.name,
    required this.kycStatus,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      mobile: json['mobile'],
      name: json['name'],
      kycStatus: json['kyc_status'],
    );
  }
}

class UserBalance {
  final String type;
  final String amount;

  UserBalance({
    required this.type,
    required this.amount,
  });

  factory UserBalance.fromJson(Map<String, dynamic> json) {
    return UserBalance(
      type: json['type'],
      amount: json['amount'],
    );
  }
}
