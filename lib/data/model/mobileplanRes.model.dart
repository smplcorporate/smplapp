// To parse this JSON data, do
//
//     final mobilePlansResponseModel = mobilePlansResponseModelFromJson(jsonString);

import 'dart:convert';

MobilePlansResponseModel mobilePlansResponseModelFromJson(String str) => MobilePlansResponseModel.fromJson(json.decode(str));

String mobilePlansResponseModelToJson(MobilePlansResponseModel data) => json.encode(data.toJson());

class MobilePlansResponseModel {
    bool status;
    String statusDesc;
    String billerType;
    String billerName;
    List<PlanDatum> planData;

    MobilePlansResponseModel({
        required this.status,
        required this.statusDesc,
        required this.billerType,
        required this.billerName,
        required this.planData,
    });

    factory MobilePlansResponseModel.fromJson(Map<String, dynamic> json) => MobilePlansResponseModel(
        status: json["status"],
        statusDesc: json["status_desc"],
        billerType: json["biller_type"],
        billerName: json["biller_name"],
        planData: List<PlanDatum>.from(json["plan_data"].map((x) => PlanDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "biller_type": billerType,
        "biller_name": billerName,
        "plan_data": List<dynamic>.from(planData.map((x) => x.toJson())),
    };
}

class PlanDatum {
    String planTab;
    String planCode;
    double planAmount;
    String talkTime;
    String validity;
    String planName;
    String planDescription;

    PlanDatum({
        required this.planTab,
        required this.planCode,
        required this.planAmount,
        required this.talkTime,
        required this.validity,
        required this.planName,
        required this.planDescription,
    });

    factory PlanDatum.fromJson(Map<String, dynamic> json) => PlanDatum(
        planTab: json["plan_tab"],
        planCode: json["plan_code"],
        planAmount: json["plan_amount"],
        talkTime: json["talk_time"],
        validity: json["validity"],
        planName: json["plan_name"],
        planDescription: json["plan_description"],
    );

    Map<String, dynamic> toJson() => {
        "plan_tab": planTab,
        "plan_code": planCode,
        "plan_amount": planAmount,
        "talk_time": talkTime,
        "validity": validity,
        "plan_name": planName,
        "plan_description": planDescription,
    };
}




class RechargeRequestModel {
  final String ipAddress;
  final String macAddress;
  final String latitude;
  final String longitude;
  final String billerCode;
  final String billerName;
  final String? circleCode; // Optional, mandatory only in specific cases
  final String param1;

  RechargeRequestModel({
    required this.ipAddress,
    required this.macAddress,
    required this.latitude,
    required this.longitude,
    required this.billerCode,
    required this.billerName,
    this.circleCode, // Nullable as it's conditionally mandatory
    required this.param1,
  });

  // Optional: Add a factory method or constructor from JSON if needed
  factory RechargeRequestModel.fromJson(Map<String, dynamic> json) {
    return RechargeRequestModel(
      ipAddress: json['ip_address'] as String,
      macAddress: json['mac_address'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      billerCode: json['biller_code'] as String,
      billerName: json['biller_name'] as String,
      circleCode: json['circle_code'] as String?, // Nullable
      param1: json['param1'] as String,
    );
  }

  // Optional: Convert to JSON for API posting
  Map<String, dynamic> toJson() {
    return {
      'ip_address': ipAddress,
      'mac_address': macAddress,
      'latitude': latitude,
      'longitude': longitude,
      'biller_code': billerCode,
      'biller_name': billerName,
      'circle_code': circleCode, // Will be null if not provided
      'param1': param1,
    };
  }
}