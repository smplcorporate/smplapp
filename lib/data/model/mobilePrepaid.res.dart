// To parse this JSON data, do
//
//     final mobilePrepaidResponse = mobilePrepaidResponseFromJson(jsonString);

import 'dart:convert';

MobilePrepaidResponse mobilePrepaidResponseFromJson(String str) => MobilePrepaidResponse.fromJson(json.decode(str));

String mobilePrepaidResponseToJson(MobilePrepaidResponse data) => json.encode(data.toJson());

class MobilePrepaidResponse {
    bool status;
    String statusDesc;
    UserBalance userBalance;
    String billerType;
    List<BillersList> billersList;
    bool isCircle;
    dynamic circleList;
    String defaultBillerCode;
    List<OldRecharge> oldRecharges;

    MobilePrepaidResponse({
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

    factory MobilePrepaidResponse.fromJson(Map<String, dynamic> json) => MobilePrepaidResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        userBalance: UserBalance.fromJson(json["user_balance"]),
        billerType: json["biller_type"],
        billersList: List<BillersList>.from(json["billers_list"].map((x) => BillersList.fromJson(x))),
        isCircle: json["is_circle"],
        circleList: json["circle_list"],
        defaultBillerCode: json["default_biller_code"],
        oldRecharges: List<OldRecharge>.from(json["old_recharges"].map((x) => OldRecharge.fromJson(x))),
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
        "old_recharges": List<dynamic>.from(oldRecharges.map((x) => x.toJson())),
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

class OldRecharge {
    String transLogo;
    String transDate;
    String transId;
    String serviceProvider;
    String serviceAccount;
    int transAmount;
    String transStatus;

    OldRecharge({
        required this.transLogo,
        required this.transDate,
        required this.transId,
        required this.serviceProvider,
        required this.serviceAccount,
        required this.transAmount,
        required this.transStatus,
    });

    factory OldRecharge.fromJson(Map<String, dynamic> json) => OldRecharge(
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
        balanceMain: json["balance_main"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "balance_main": balanceMain,
    };
}
