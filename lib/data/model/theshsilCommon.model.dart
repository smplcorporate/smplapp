// To parse this JSON data, do
//
//     final thehSillCommonList = thehSillCommonListFromJson(jsonString);

import 'dart:convert';

ThehSillCommonList thehSillCommonListFromJson(String str) => ThehSillCommonList.fromJson(json.decode(str));

String thehSillCommonListToJson(ThehSillCommonList data) => json.encode(data.toJson());

class ThehSillCommonList {
    bool status;
    String statusDesc;
    int districtId;
    String districtName;
    List<TehsilList> tehsilList;

    ThehSillCommonList({
        required this.status,
        required this.statusDesc,
        required this.districtId,
        required this.districtName,
        required this.tehsilList,
    });

    factory ThehSillCommonList.fromJson(Map<String, dynamic> json) => ThehSillCommonList(
        status: json["status"],
        statusDesc: json["status_desc"],
        districtId: json["district_id"],
        districtName: json["district_name"],
        tehsilList: List<TehsilList>.from(json["tehsil_list"].map((x) => TehsilList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "district_id": districtId,
        "district_name": districtName,
        "tehsil_list": List<dynamic>.from(tehsilList.map((x) => x.toJson())),
    };
}

class TehsilList {
    dynamic tehsilId;
    String tehsilName;

    TehsilList({
        required this.tehsilId,
        required this.tehsilName,
    });

    factory TehsilList.fromJson(Map<String, dynamic> json) => TehsilList(
        tehsilId: json["tehsil_id"],
        tehsilName: json["tehsil_name"],
    );

    Map<String, dynamic> toJson() => {
        "tehsil_id": tehsilId,
        "tehsil_name": tehsilName,
    };
}
