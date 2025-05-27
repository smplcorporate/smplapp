import 'dart:convert';

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


// To parse this JSON data, do
//
//     final registerResponseValidate = registerResponseValidateFromJson(jsonString);


RegisterResponseValidate registerResponseValidateFromJson(String str) => RegisterResponseValidate.fromJson(json.decode(str));

String registerResponseValidateToJson(RegisterResponseValidate data) => json.encode(data.toJson());

class RegisterResponseValidate {
    bool status;
    String statusDesc;
    UserDetails userDetails;

    String sessionToken;

    RegisterResponseValidate({
        required this.status,
        required this.statusDesc,
        required this.userDetails,

        required this.sessionToken,
    });

    factory RegisterResponseValidate.fromJson(Map<String, dynamic> json) => RegisterResponseValidate(
        status: json["status"],
        statusDesc: json["status_desc"],
        userDetails: UserDetails.fromJson(json["user_details"]),

        sessionToken: json["session_token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "user_details": userDetails.toJson(),

        "session_token": sessionToken,
    };
}

class UserBalance {
    int balanceMain;

    UserBalance({
        required this.balanceMain,
    });

    factory UserBalance.fromJson(Map<String, dynamic> json) => UserBalance(
        balanceMain: json["balance_main"],
    );

    Map<String, dynamic> toJson() => {
        "balance_main": balanceMain,
    };
}

class UserDetails {
    String userId;
    String userMobile;
    String userName;
    int userKycStatus;

    UserDetails({
        required this.userId,
        required this.userMobile,
        required this.userName,
        required this.userKycStatus,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        userId: json["user_id"],
        userMobile: json["user_mobile"],
        userName: json["user_name"],
        userKycStatus: json["user_kyc_status"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_mobile": userMobile,
        "user_name": userName,
        "user_kyc_status": userKycStatus,
    };
}
