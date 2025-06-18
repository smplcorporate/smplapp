// To parse this JSON data, do
//
//     final walletBalancemodel = walletBalancemodelFromJson(jsonString);

import 'dart:convert';

WalletBalancemodel walletBalancemodelFromJson(String str) => WalletBalancemodel.fromJson(json.decode(str));

String walletBalancemodelToJson(WalletBalancemodel data) => json.encode(data.toJson());

class WalletBalancemodel {
    bool status;
    String statusDesc;
    UserBalance userBalance;

    WalletBalancemodel({
        required this.status,
        required this.statusDesc,
        required this.userBalance,
    });

    factory WalletBalancemodel.fromJson(Map<String, dynamic> json) => WalletBalancemodel(
        status: json["status"],
        statusDesc: json["status_desc"],
        userBalance: UserBalance.fromJson(json["user_balance"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "user_balance": userBalance.toJson(),
    };
}

class UserBalance {
    double balanceMain;
    int balanceMainLocked;
    int balanceMainUnclear;

    UserBalance({
        required this.balanceMain,
        required this.balanceMainLocked,
        required this.balanceMainUnclear,
    });

    factory UserBalance.fromJson(Map<String, dynamic> json) => UserBalance(
        balanceMain: json["balance_main"]?.toDouble(),
        balanceMainLocked: json["balance_main_locked"],
        balanceMainUnclear: json["balance_main_unclear"],
    );

    Map<String, dynamic> toJson() => {
        "balance_main": balanceMain,
        "balance_main_locked": balanceMainLocked,
        "balance_main_unclear": balanceMainUnclear,
    };
}
