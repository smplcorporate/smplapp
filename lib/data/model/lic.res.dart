// To parse this JSON data, do
//
//     final licModelResponse = licModelResponseFromJson(jsonString);

import 'dart:convert';

LicModelResponse licModelResponseFromJson(String str) => LicModelResponse.fromJson(json.decode(str));

String licModelResponseToJson(LicModelResponse data) => json.encode(data.toJson());

class LicModelResponse {
    bool status;
    String statusDesc;
    UserBalance userBalance;
    String billerType;
    List<BillersList> billersList;
    bool isCircle;
    dynamic circleList;
    String defaultBillerCode;
    List<dynamic> oldBills;

    LicModelResponse({
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

    factory LicModelResponse.fromJson(Map<String, dynamic> json) => LicModelResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        userBalance: UserBalance.fromJson(json["user_balance"]),
        billerType: json["biller_type"],
        billersList: List<BillersList>.from(json["billers_list"].map((x) => BillersList.fromJson(x))),
        isCircle: json["is_circle"],
        circleList: json["circle_list"],
        defaultBillerCode: json["default_biller_code"],
        oldBills: List<dynamic>.from(json["old_bills"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "user_balance": userBalance.toJson(),
        "biller_type": billerType,
        "billers_list": List<dynamic>.from(billersList.map((x) => x.toJson())),
        "is_circle": isCircle,
        "circle_list": circleList,
        "default_biller_code": defaultBillerCode,
        "old_bills": List<dynamic>.from(oldBills.map((x) => x)),
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
