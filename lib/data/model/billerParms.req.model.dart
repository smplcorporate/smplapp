// To parse this JSON data, do
//
//     final billerParamRequest = billerParamRequestFromJson(jsonString);

import 'dart:convert';

BillerParamRequest billerParamRequestFromJson(String str) => BillerParamRequest.fromJson(json.decode(str));

String billerParamRequestToJson(BillerParamRequest data) => json.encode(data.toJson());

class BillerParamRequest {
    String ipAddress;
    String macAddress;
    String latitude;
    String longitude;
    String billerCode;
    String billerName;

    BillerParamRequest({
        required this.ipAddress,
        required this.macAddress,
        required this.latitude,
        required this.longitude,
        required this.billerCode,
        required this.billerName,
    });

    factory BillerParamRequest.fromJson(Map<String, dynamic> json) => BillerParamRequest(
        ipAddress: json["ip_address"],
        macAddress: json["mac_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        billerCode: json["biller_code"],
        billerName: json["biller_name"],
    );

    Map<String, dynamic> toJson() => {
        "ip_address": ipAddress,
        "mac_address": macAddress,
        "latitude": latitude,
        "longitude": longitude,
        "biller_code": billerCode,
        "biller_name": billerName,
    };
}
