// To parse this JSON data, do
//
//     final fetchBillModel = fetchBillModelFromJson(jsonString);

import 'dart:convert';

FetchBillModel fetchBillModelFromJson(String str) => FetchBillModel.fromJson(json.decode(str));

String fetchBillModelToJson(FetchBillModel data) => json.encode(data.toJson());

class FetchBillModel {
    String ipAddress;
    String macAddress;
    String latitude;
    String longitude;
    String billerCode;
    String billerName;
    String circleCode;
    String param1;
    String param2;
    String param3;
    String param4;
    String param5;

    FetchBillModel({
        required this.ipAddress,
        required this.macAddress,
        required this.latitude,
        required this.longitude,
        required this.billerCode,
        required this.billerName,
        required this.circleCode,
        required this.param1,
        required this.param2,
        required this.param3,
        required this.param4,
        required this.param5,
    });

    factory FetchBillModel.fromJson(Map<String, dynamic> json) => FetchBillModel(
        ipAddress: json["ip_address"],
        macAddress: json["mac_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        billerCode: json["biller_code"],
        billerName: json["biller_name"],
        circleCode: json["circle_code"],
        param1: json["param1"],
        param2: json["param2"],
        param3: json["param3"],
        param4: json["param4"],
        param5: json["param5"],
    );

    Map<String, dynamic> toJson() => {
        "ip_address": ipAddress,
        "mac_address": macAddress,
        "latitude": latitude,
        "longitude": longitude,
        "biller_code": billerCode,
        "biller_name": billerName,
        "circle_code": circleCode,
        "param1": param1,
        "param2": param2,
        "param3": param3,
        "param4": param4,
        "param5": param5,
    };
}
