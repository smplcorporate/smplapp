// To parse this JSON data, do
//
//     final verfiyOtpBody = verfiyOtpBodyFromJson(jsonString);

import 'dart:convert';

VerfiyOtpBody verfiyOtpBodyFromJson(String str) => VerfiyOtpBody.fromJson(json.decode(str));

String verfiyOtpBodyToJson(VerfiyOtpBody data) => json.encode(data.toJson());

class VerfiyOtpBody {
    String userMobile;
    String ipAddress;
    String macAddress;
    String latitude;
    String longitude;
    String otpCheck;
    String requestId;

    VerfiyOtpBody({
        required this.userMobile,
        required this.ipAddress,
        required this.macAddress,
        required this.latitude,
        required this.longitude,
        required this.otpCheck,
        required this.requestId,
    });

    factory VerfiyOtpBody.fromJson(Map<String, dynamic> json) => VerfiyOtpBody(
        userMobile: json["user_mobile"],
        ipAddress: json["ip_address"],
        macAddress: json["mac_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        otpCheck: json["otp_check"],
        requestId: json["request_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_mobile": userMobile,
        "ip_address": ipAddress,
        "mac_address": macAddress,
        "latitude": latitude,
        "longitude": longitude,
        "otp_check": otpCheck,
        "request_id": requestId,
    };
}


// To parse this JSON data, do
//
//     final verfiyOtpResponse = verfiyOtpResponseFromJson(jsonString);



VerfiyOtpResponse verfiyOtpResponseFromJson(String str) => VerfiyOtpResponse.fromJson(json.decode(str));

String verfiyOtpResponseToJson(VerfiyOtpResponse data) => json.encode(data.toJson());

class VerfiyOtpResponse {
    bool status;
    String statusDesc;
    UserDetails userDetails;
    UserBalance userBalance;
    String sessionToken;

    VerfiyOtpResponse({
        required this.status,
        required this.statusDesc,
        required this.userDetails,
        required this.userBalance,
        required this.sessionToken,
    });

    factory VerfiyOtpResponse.fromJson(Map<String, dynamic> json) => VerfiyOtpResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        userDetails: UserDetails.fromJson(json["user_details"]),
        userBalance: UserBalance.fromJson(json["user_balance"]),
        sessionToken: json["session_token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "user_details": userDetails.toJson(),
        "user_balance": userBalance.toJson(),
        "session_token": sessionToken,
    };
}

class UserBalance {
    double balanceMain;

    UserBalance({
        required this.balanceMain,
    });

    factory UserBalance.fromJson(Map<String, dynamic> json) => UserBalance(
        balanceMain: json["balance_main"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "balance_main": balanceMain,
    };
}

class UserDetails {
    String userId;
    String userMobile;
    String userName;
    String userKycStatus;

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
