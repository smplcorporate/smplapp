// To parse this JSON data, do
//
//     final distrubuterBodyRes = distrubuterBodyResFromJson(jsonString);

import 'dart:convert';

DistrubuterBodyRes distrubuterBodyResFromJson(String str) => DistrubuterBodyRes.fromJson(json.decode(str));

String distrubuterBodyResToJson(DistrubuterBodyRes data) => json.encode(data.toJson());

class DistrubuterBodyRes {
    bool status;
    String statusDesc;
    String stateId;
    String districtId;
    List<LpgDistributorsList> lpgDistributorsList;

    DistrubuterBodyRes({
        required this.status,
        required this.statusDesc,
        required this.stateId,
        required this.districtId,
        required this.lpgDistributorsList,
    });

    factory DistrubuterBodyRes.fromJson(Map<String, dynamic> json) => DistrubuterBodyRes(
        status: json["status"],
        statusDesc: json["status_desc"],
        stateId: json["state_id"],
        districtId: json["district_id"],
        lpgDistributorsList: List<LpgDistributorsList>.from(json["lpg_distributors_list"].map((x) => LpgDistributorsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "state_id": stateId,
        "district_id": districtId,
        "lpg_distributors_list": List<dynamic>.from(lpgDistributorsList.map((x) => x.toJson())),
    };
}

class LpgDistributorsList {
    String distributorId;
    String distributorName;

    LpgDistributorsList({
        required this.distributorId,
        required this.distributorName,
    });

    factory LpgDistributorsList.fromJson(Map<String, dynamic> json) => LpgDistributorsList(
        distributorId: json["distributor_id"],
        distributorName: json["distributor_name"],
    );

    Map<String, dynamic> toJson() => {
        "distributor_id": distributorId,
        "distributor_name": distributorName,
    };
}
