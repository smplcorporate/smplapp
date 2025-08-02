// To parse this JSON data, do
//
//     final billerParamResponse = billerParamResponseFromJson(jsonString);

import 'dart:convert';

BillerParamResponse billerParamResponseFromJson(String str) => BillerParamResponse.fromJson(json.decode(str));

String billerParamResponseToJson(BillerParamResponse data) => json.encode(data.toJson());

class BillerParamResponse {
    bool status;
    String statusDesc;
    String billerType;
    String billerCode;
    String billerName;
    bool fetchOption;
    bool isParam1;
    Param param1;
    bool isParam2;
    Param param2;
    bool? isParam3;
    Param? param3;
    bool? isParam4;
    Param? param4;
    bool? isParam5;
    Param? param5;

    BillerParamResponse({
        required this.status,
        required this.statusDesc,
        required this.billerType,
        required this.billerCode,
        required this.billerName,
        required this.fetchOption,
        required this.isParam1,
        required this.param1,
        required this.isParam2,
        required this.param2,
        required this.isParam3,
        required this.param3,
        required this.isParam4,
        required this.param4,
        required this.isParam5,
        required this.param5,
    });

    factory BillerParamResponse.fromJson(Map<String, dynamic> json) => BillerParamResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        billerType: json["biller_type"],
        billerCode: json["biller_code"],
        billerName: json["biller_name"],
        fetchOption: json["fetch_option"],
        isParam1: json["is_param1"],
        param1: Param.fromJson(json["param1"]),
        isParam2: json["is_param2"],
        param2: Param.fromJson(json["param2"]),
        isParam3: json["is_param3"] ?? false,
        param3: json["param3"]  == null ? null : Param.fromJson(json["param3"]),
        isParam4: json["is_param4"] ?? false,
        param4: json["param4"] == null ? null :Param.fromJson(json["param4"]),
        isParam5: json["is_param5"] ?? false,
        param5: json["param5"]  == null ? null :Param.fromJson(json["param5"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "biller_type": billerType,
        "biller_code": billerCode,
        "biller_name": billerName,
        "fetch_option": fetchOption,
        "is_param1": isParam1,
        "param1": param1.toJson(),
        "is_param2": isParam2,
        "param2": param2.toJson(),
        "is_param3": isParam3,
        "param3": param3?.toJson(),
        "is_param4": isParam4,
        "param4": param4?.toJson(),
        "is_param5": isParam5,
        "param5": param5?.toJson(),
    };
}

class Param {
    String name;

    Param({
        required this.name,
    });

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
