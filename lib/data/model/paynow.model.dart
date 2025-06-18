// To parse this JSON data, do
//
//     final payNowModel = payNowModelFromJson(jsonString);

import 'dart:convert';

PayNowModel payNowModelFromJson(String str) => PayNowModel.fromJson(json.decode(str));

String payNowModelToJson(PayNowModel data) => json.encode(data.toJson());

class PayNowModel {
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
    String customerName;
    String billNo;
    DateTime dueDate;
    String billDate;
    String billAmount;
    String returnTransid;
    String returnFetchid;
    String returnBillid;
    String couponCode;
    String userMpin;

    PayNowModel({
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
        required this.customerName,
        required this.billNo,
        required this.dueDate,
        required this.billDate,
        required this.billAmount,
        required this.returnTransid,
        required this.returnFetchid,
        required this.returnBillid,
        required this.couponCode,
        required this.userMpin,
    });

    factory PayNowModel.fromJson(Map<String, dynamic> json) => PayNowModel(
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
        customerName: json["customer_name"],
        billNo: json["bill_no"],
        dueDate: DateTime.parse(json["due_date"]),
        billDate: json["bill_date"],
        billAmount: json["bill_amount"],
        returnTransid: json["return_transid"],
        returnFetchid: json["return_fetchid"],
        returnBillid: json["return_billid"],
        couponCode: json["coupon_code"],
        userMpin: json["user_mpin"],
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
        "customer_name": customerName,
        "bill_no": billNo,
        "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "bill_date": billDate,
        "bill_amount": billAmount,
        "return_transid": returnTransid,
        "return_fetchid": returnFetchid,
        "return_billid": returnBillid,
        "coupon_code": couponCode,
        "user_mpin": userMpin,
    };
}
