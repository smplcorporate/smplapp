// To parse this JSON data, do
//
//     final electricityModel = electricityModelFromJson(jsonString);

import 'dart:convert';

ElectricityModel electricityModelFromJson(String str) => ElectricityModel.fromJson(json.decode(str));

String electricityModelToJson(ElectricityModel data) => json.encode(data.toJson());

class ElectricityModel {
    bool status;
    String statusDesc;
    UserBalance userBalance;
    String billerType;
    List<BillersList> billersList;
    bool isCircle;
    List<CircleList>? circleList;
    String defaultBillerCode;
    List<OldBill> oldBills;

    ElectricityModel({
        required this.status,
        required this.statusDesc,
        required this.userBalance,
        required this.billerType,
        required this.billersList,
        required this.isCircle,
        required this.circleList,
        required this.defaultBillerCode,
        required this.oldBills,
    });

   factory ElectricityModel.fromJson(Map<String, dynamic> json) => ElectricityModel(
  status: json["status"],
  statusDesc: json["status_desc"],
  userBalance: UserBalance.fromJson(json["user_balance"]),
  billerType: json["biller_type"],
  billersList: List<BillersList>.from(json["billers_list"].map((x) => BillersList.fromJson(x))),
  isCircle: json["is_circle"],
  circleList: json["circle_list"] != null
      ? List<CircleList>.from(json["circle_list"].map((x) => CircleList.fromJson(x)))
      : null,
  defaultBillerCode: json["default_biller_code"],
  oldBills: List<OldBill>.from(json["old_bills"].map((x) => OldBill.fromJson(x))),
);


    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "user_balance": userBalance.toJson(),
        "biller_type": billerType,
        "billers_list": List<dynamic>.from(billersList.map((x) => x.toJson())),
        "is_circle": isCircle,
       "circle_list": circleList != null
    ? List<dynamic>.from(circleList!.map((x) => x.toJson()))
    : null,
        "default_biller_code": defaultBillerCode,
        "old_bills": List<dynamic>.from(oldBills.map((x) => x.toJson())),
    };
}

class BillersList {
    String billerName;
    String billerCode;

    BillersList({
        required this.billerName,
        required this.billerCode,
    });

    factory BillersList.fromJson(Map<String, dynamic> json) => BillersList(
        billerName: json["biller_name"],
        billerCode: json["biller_code"],
    );

    Map<String, dynamic> toJson() => {
        "biller_name": billerName,
        "biller_code": billerCode,
    };
}

class CircleList {
    String circleName;
    String circleId;

    CircleList({
        required this.circleName,
        required this.circleId,
    });

    factory CircleList.fromJson(Map<String, dynamic> json) => CircleList(
        circleName: json["circle_name"],
        circleId: json["circle_id"],
    );

    Map<String, dynamic> toJson() => {
        "circle_name": circleName,
        "circle_id": circleId,
    };
}

class OldBill {
    String transLogo;
    String transDate;
    String transId;
    String serviceProvider;
    String serviceAccount;
    double transAmount;
    String transStatus;

    OldBill({
        required this.transLogo,
        required this.transDate,
        required this.transId,
        required this.serviceProvider,
        required this.serviceAccount,
        required this.transAmount,
        required this.transStatus,
    });

    factory OldBill.fromJson(Map<String, dynamic> json) => OldBill(
        transLogo: json["trans_logo"],
        transDate: json["trans_date"],
        transId: json["trans_id"],
        serviceProvider: json["service_provider"],
        serviceAccount: json["service_account"],
        transAmount: json["trans_amount"],
        transStatus: json["trans_status"],
    );

    Map<String, dynamic> toJson() => {
        "trans_logo": transLogo,
        "trans_date": transDate,
        "trans_id": transId,
        "service_provider": serviceProvider,
        "service_account": serviceAccount,
        "trans_amount": transAmount,
        "trans_status": transStatus,
    };
}

class UserBalance {
    double balanceMain;

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



ElectricityBody electricityBodyFromJson(String str) => ElectricityBody.fromJson(json.decode(str));

String electricityBodyToJson(ElectricityBody data) => json.encode(data.toJson());

class ElectricityBody {
    String ipAddress;
    String macAddress;
    String latitude;
    String longitude;

    ElectricityBody({
        required this.ipAddress,
        required this.macAddress,
        required this.latitude,
        required this.longitude,
    });

    factory ElectricityBody.fromJson(Map<String, dynamic> json) => ElectricityBody(
        ipAddress: json["ip_address"],
        macAddress: json["mac_address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "ip_address": ipAddress,
        "mac_address": macAddress,
        "latitude": latitude,
        "longitude": longitude,
    };
}
