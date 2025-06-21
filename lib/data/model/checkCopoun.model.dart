// To parse this JSON data, do
//
//     final checkCouponModel = checkCouponModelFromJson(jsonString);

import 'dart:convert';

CheckCouponModel checkCouponModelFromJson(String str) => CheckCouponModel.fromJson(json.decode(str));

String checkCouponModelToJson(CheckCouponModel data) => json.encode(data.toJson());

class CheckCouponModel {
    String ipAddress;
    String macAddress;
    String latitude;
    String longitude;
    String billerCode;
    String billerName;
    String param1;
    String transAmount;
    String couponCode;

    CheckCouponModel({
        required this.ipAddress,
        required this.macAddress,
        required this.latitude,
        required this.longitude,
        required this.billerCode,
        required this.billerName,
        required this.param1,
        required this.transAmount,
        required this.couponCode,
    });

    factory CheckCouponModel.fromJson(Map<String, dynamic> json) => CheckCouponModel(
        ipAddress: json["ip_address"],
        macAddress: json["mac_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        billerCode: json["biller_code"],
        billerName: json["biller_name"],
        param1: json["param1"],
        transAmount: json["trans_amount"],
        couponCode: json["coupon_code"],
    );

    Map<String, dynamic> toJson() => {
        "ip_address": ipAddress,
        "mac_address": macAddress,
        "latitude": latitude,
        "longitude": longitude,
        "biller_code": billerCode,
        "biller_name": billerName,
        "param1": param1,
        "trans_amount": transAmount,
        "coupon_code": couponCode,
    };
}
