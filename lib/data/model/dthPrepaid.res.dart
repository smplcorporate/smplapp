// To parse this JSON data, do
//
//     final dthPrepaidResponse = dthPrepaidResponseFromJson(jsonString);

import 'dart:convert';

DthPrepaidResponse dthPrepaidResponseFromJson(String str) => DthPrepaidResponse.fromJson(json.decode(str));

String dthPrepaidResponseToJson(DthPrepaidResponse data) => json.encode(data.toJson());

class DthPrepaidResponse {
    bool status;
    String statusDesc;
    UserBalance userBalance;
    String billerType;
    List<BillersList> billersList;
    bool isCircle;
    dynamic circleList;
    String defaultBillerCode;
    List<dynamic> oldRecharges;

    DthPrepaidResponse({
        required this.status,
        required this.statusDesc,
        required this.userBalance,
        required this.billerType,
        required this.billersList,
        required this.isCircle,
        required this.circleList,
        required this.defaultBillerCode,
        required this.oldRecharges,
    });

    factory DthPrepaidResponse.fromJson(Map<String, dynamic> json) => DthPrepaidResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        userBalance: UserBalance.fromJson(json["user_balance"]),
        billerType: json["biller_type"],
        billersList: List<BillersList>.from(json["billers_list"].map((x) => BillersList.fromJson(x))),
        isCircle: json["is_circle"],
        circleList: json["circle_list"],
        defaultBillerCode: json["default_biller_code"],
        oldRecharges: List<dynamic>.from(json["old_recharges"].map((x) => x)),
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
        "old_recharges": List<dynamic>.from(oldRecharges.map((x) => x)),
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
