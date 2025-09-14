// To parse this JSON data, do
//
//     final distirctCommonModel = distirctCommonModelFromJson(jsonString);

import 'dart:convert';

DistirctCommonModel distirctCommonModelFromJson(String str) => DistirctCommonModel.fromJson(json.decode(str));

String distirctCommonModelToJson(DistirctCommonModel data) => json.encode(data.toJson());

class DistirctCommonModel {
    bool status;
    String statusDesc;
    int stateId;
    String stateName;
    List<DistrictList> districtList;

    DistirctCommonModel({
        required this.status,
        required this.statusDesc,
        required this.stateId,
        required this.stateName,
        required this.districtList,
    });

    factory DistirctCommonModel.fromJson(Map<String, dynamic> json) => DistirctCommonModel(
        status: json["status"],
        statusDesc: json["status_desc"],
        stateId: json["state_id"],
        stateName: json["state_name"],
        districtList: List<DistrictList>.from(json["district_list"].map((x) => DistrictList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "state_id": stateId,
        "state_name": stateName,
        "district_list": List<dynamic>.from(districtList.map((x) => x.toJson())),
    };
}

class DistrictList {
    dynamic districtId;
    String districtName;

    DistrictList({
        required this.districtId,
        required this.districtName,
    });

    factory DistrictList.fromJson(Map<String, dynamic> json) => DistrictList(
        districtId: json["district_id"],
        districtName: json["district_name"],
    );

    Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
    };
}
