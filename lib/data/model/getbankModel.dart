// To parse this JSON data, do
//
//     final getBankDetailModel = getBankDetailModelFromJson(jsonString);

import 'dart:convert';

GetBankDetailModel getBankDetailModelFromJson(String str) => GetBankDetailModel.fromJson(json.decode(str));

String getBankDetailModelToJson(GetBankDetailModel data) => json.encode(data.toJson());

class GetBankDetailModel {
    bool status;
    String statusDesc;
    List<BankDetail> bankDetails;

    GetBankDetailModel({
        required this.status,
        required this.statusDesc,
        required this.bankDetails,
    });

    factory GetBankDetailModel.fromJson(Map<String, dynamic> json) => GetBankDetailModel(
        status: json["status"],
        statusDesc: json["status_desc"],
        bankDetails: List<BankDetail>.from(json["bank_details"].map((x) => BankDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "bank_details": List<dynamic>.from(bankDetails.map((x) => x.toJson())),
    };
}

class BankDetail {
    int bankId;
    String bankName;
    String accountNo;
    String accountName;
    String ifscCode;

    BankDetail({
        required this.bankId,
        required this.bankName,
        required this.accountNo,
        required this.accountName,
        required this.ifscCode,
    });

    factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
        bankId: json["bank_id"],
        bankName: json["bank_name"],
        accountNo: json["account_no"],
        accountName: json["account_name"],
        ifscCode: json["ifsc_code"],
    );

    Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "bank_name": bankName,
        "account_no": accountNo,
        "account_name": accountName,
        "ifsc_code": ifscCode,
    };
}


// To parse this JSON data, do
//
//     final getBankBodymodel = getBankBodymodelFromJson(jsonString);



GetBankBodymodel getBankBodymodelFromJson(String str) => GetBankBodymodel.fromJson(json.decode(str));

String getBankBodymodelToJson(GetBankBodymodel data) => json.encode(data.toJson());

class GetBankBodymodel {
    String bankId;

    GetBankBodymodel({
        required this.bankId,
    });

    factory GetBankBodymodel.fromJson(Map<String, dynamic> json) => GetBankBodymodel(
        bankId: json["bank_id"],
    );

    Map<String, dynamic> toJson() => {
        "bank_id": bankId,
    };
}
