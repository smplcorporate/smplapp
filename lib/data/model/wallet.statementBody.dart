// To parse this JSON data, do
//
//     final walletStateMentBody = walletStateMentBodyFromJson(jsonString);

import 'dart:convert';

WalletStateMentBody walletStateMentBodyFromJson(String str) => WalletStateMentBody.fromJson(json.decode(str));

String walletStateMentBodyToJson(WalletStateMentBody data) => json.encode(data.toJson());

class WalletStateMentBody {
    String dateFrom;
    String dateTo;
    String transId;

    WalletStateMentBody({
        required this.dateFrom,
        required this.dateTo,
        required this.transId,
    });

    factory WalletStateMentBody.fromJson(Map<String, dynamic> json) => WalletStateMentBody(
        dateFrom: json["date_from"],
        dateTo: json["date_to"],
        transId: json["trans_id"],
    );

    Map<String, dynamic> toJson() => {
        "date_from": dateFrom,
        "date_to": dateTo,
        "trans_id": transId,
    };
}


// To parse this JSON data, do
//
//     final walletStateMentRes = walletStateMentResFromJson(jsonString);



WalletStateMentRes walletStateMentResFromJson(String str) => WalletStateMentRes.fromJson(json.decode(str));

String walletStateMentResToJson(WalletStateMentRes data) => json.encode(data.toJson());

class WalletStateMentRes {
    bool status;
    String statusDesc;
    double balance;
    int balanceLocked;
    int balanceUnclear;
    List<StatementList> statementList;

    WalletStateMentRes({
        required this.status,
        required this.statusDesc,
        required this.balance,
        required this.balanceLocked,
        required this.balanceUnclear,
        required this.statementList,
    });

    factory WalletStateMentRes.fromJson(Map<String, dynamic> json) => WalletStateMentRes(
        status: json["status"],
        statusDesc: json["status_desc"],
        balance: json["balance"]?.toDouble(),
        balanceLocked: json["balance_locked"],
        balanceUnclear: json["balance_unclear"],
        statementList: List<StatementList>.from(json["statement_list"].map((x) => StatementList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "balance": balance,
        "balance_locked": balanceLocked,
        "balance_unclear": balanceUnclear,
        "statement_list": List<dynamic>.from(statementList.map((x) => x.toJson())),
    };
}

class StatementList {
    String transLogo;
    String date;
    String transType;
    String transId;
    int balOpen;
    int credit;
    int debit;
    int balClose;
    String remark;

    StatementList({
        required this.transLogo,
        required this.date,
        required this.transType,
        required this.transId,
        required this.balOpen,
        required this.credit,
        required this.debit,
        required this.balClose,
        required this.remark,
    });

    factory StatementList.fromJson(Map<String, dynamic> json) => StatementList(
        transLogo: json["trans_logo"],
        date: json["date"],
        transType: json["trans_type"],
        transId: json["trans_id"],
        balOpen: json["bal_open"],
        credit: json["credit"],
        debit: json["debit"],
        balClose: json["bal_close"],
        remark: json["remark"],
    );

    Map<String, dynamic> toJson() => {
        "trans_logo": transLogo,
        "date": date,
        "trans_type": transType,
        "trans_id": transId,
        "bal_open": balOpen,
        "credit": credit,
        "debit": debit,
        "bal_close": balClose,
        "remark": remark,
    };
}
