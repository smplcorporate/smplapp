// To parse this JSON data, do
//
//     final loginBodyRequest = loginBodyRequestFromJson(jsonString);

import 'dart:convert';

LoginBodyRequest loginBodyRequestFromJson(String str) => LoginBodyRequest.fromJson(json.decode(str));

String loginBodyRequestToJson(LoginBodyRequest data) => json.encode(data.toJson());

class LoginBodyRequest {
    String userMobile;
    String ipAddress;
    String macAddress;
    String latitude;
    String longitude;

    LoginBodyRequest({
        required this.userMobile,
        required this.ipAddress,
        required this.macAddress,
        required this.latitude,
        required this.longitude,
    });

    factory LoginBodyRequest.fromJson(Map<String, dynamic> json) => LoginBodyRequest(
        userMobile: json["user_mobile"],
        ipAddress: json["ip_address"],
        macAddress: json["mac_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "user_mobile": userMobile,
        "ip_address": ipAddress,
        "mac_address": macAddress,
        "latitude": latitude,
        "longitude": longitude,
    };
}

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool status;
    String statusDesc;
    String requestId;
    int validSeconds;

    LoginResponse({
        required this.status,
        required this.statusDesc,
        required this.requestId,
        required this.validSeconds,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        requestId: json["request_id"],
        validSeconds: json["valid_seconds"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "request_id": requestId,
        "valid_seconds": validSeconds,
    };
}
