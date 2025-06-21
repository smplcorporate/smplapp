// To parse this JSON data, do
//
//     final addwalletRequestPageloadModel = addwalletRequestPageloadModelFromJson(jsonString);

import 'dart:convert';

AddwalletRequestPageloadModel addwalletRequestPageloadModelFromJson(String str) => AddwalletRequestPageloadModel.fromJson(json.decode(str));

String addwalletRequestPageloadModelToJson(AddwalletRequestPageloadModel data) => json.encode(data.toJson());

class AddwalletRequestPageloadModel {
    bool status;
    String statusDesc;
    UserBalance userBalance;
    List<CompanyBanksList> companyBanksList;
    List<TransferType> transferType;
    List<InstructionsList> instructionsList;

    AddwalletRequestPageloadModel({
        required this.status,
        required this.statusDesc,
        required this.userBalance,
        required this.companyBanksList,
        required this.transferType,
        required this.instructionsList,
    });

    factory AddwalletRequestPageloadModel.fromJson(Map<String, dynamic> json) => AddwalletRequestPageloadModel(
        status: json["status"],
        statusDesc: json["status_desc"],
        userBalance: UserBalance.fromJson(json["user_balance"]),
        companyBanksList: List<CompanyBanksList>.from(json["company_banks_list"].map((x) => CompanyBanksList.fromJson(x))),
        transferType: List<TransferType>.from(json["transfer_type"].map((x) => TransferType.fromJson(x))),
        instructionsList: List<InstructionsList>.from(json["instructions_list"].map((x) => InstructionsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "user_balance": userBalance.toJson(),
        "company_banks_list": List<dynamic>.from(companyBanksList.map((x) => x.toJson())),
        "transfer_type": List<dynamic>.from(transferType.map((x) => x.toJson())),
        "instructions_list": List<dynamic>.from(instructionsList.map((x) => x.toJson())),
    };
}

class CompanyBanksList {
    int bankId;
    String bankName;

    CompanyBanksList({
        required this.bankId,
        required this.bankName,
    });

    factory CompanyBanksList.fromJson(Map<String, dynamic> json) => CompanyBanksList(
        bankId: json["bank_id"],
        bankName: json["bank_name"],
    );

    Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "bank_name": bankName,
    };
}

class InstructionsList {
    int instId;
    String instName;

    InstructionsList({
        required this.instId,
        required this.instName,
    });

    factory InstructionsList.fromJson(Map<String, dynamic> json) => InstructionsList(
        instId: json["inst_id"],
        instName: json["inst_name"],
    );

    Map<String, dynamic> toJson() => {
        "inst_id": instId,
        "inst_name": instName,
    };
}

class TransferType {
    String transferCode;
    String transferName;

    TransferType({
        required this.transferCode,
        required this.transferName,
    });

    factory TransferType.fromJson(Map<String, dynamic> json) => TransferType(
        transferCode: json["transfer_code"],
        transferName: json["transfer_name"],
    );

    Map<String, dynamic> toJson() => {
        "transfer_code": transferCode,
        "transfer_name": transferName,
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
