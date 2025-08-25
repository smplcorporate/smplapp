// To parse this JSON data, do
//
//     final distrcBodyResponse = distrcBodyResponseFromJson(jsonString);

import 'dart:convert';

DistrcBodyResponse distrcBodyResponseFromJson(String str) => DistrcBodyResponse.fromJson(json.decode(str));

String distrcBodyResponseToJson(DistrcBodyResponse data) => json.encode(data.toJson());

class DistrcBodyResponse {
    bool status;
    String statusDesc;
    String stateId;
    List<LpgDistrictsList> lpgDistrictsList;

    DistrcBodyResponse({
        required this.status,
        required this.statusDesc,
        required this.stateId,
        required this.lpgDistrictsList,
    });

    factory DistrcBodyResponse.fromJson(Map<String, dynamic> json) => DistrcBodyResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        stateId: json["state_id"],
        lpgDistrictsList: List<LpgDistrictsList>.from(json["lpg_districts_list"].map((x) => LpgDistrictsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "state_id": stateId,
        "lpg_districts_list": List<dynamic>.from(lpgDistrictsList.map((x) => x.toJson())),
    };
}

class LpgDistrictsList {
    String districtId;
    String districtName;

    LpgDistrictsList({
        required this.districtId,
        required this.districtName,
    });

    factory LpgDistrictsList.fromJson(Map<String, dynamic> json) => LpgDistrictsList(
        districtId: json["district_id"],
        districtName: json["district_name"],
    );

    Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
    };
}
