// To parse this JSON data, do
//
//     final lpgStateListRes = lpgStateListResFromJson(jsonString);

import 'dart:convert';

LpgStateListRes lpgStateListResFromJson(String str) => LpgStateListRes.fromJson(json.decode(str));

String lpgStateListResToJson(LpgStateListRes data) => json.encode(data.toJson());

class LpgStateListRes {
    bool status;
    String statusDesc;
    List<LpgStatesList> lpgStatesList;

    LpgStateListRes({
        required this.status,
        required this.statusDesc,
        required this.lpgStatesList,
    });

    factory LpgStateListRes.fromJson(Map<String, dynamic> json) => LpgStateListRes(
        status: json["status"],
        statusDesc: json["status_desc"],
        lpgStatesList: List<LpgStatesList>.from(json["lpg_states_list"].map((x) => LpgStatesList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "lpg_states_list": List<dynamic>.from(lpgStatesList.map((x) => x.toJson())),
    };
}

class LpgStatesList {
    String stateId;
    String stateName;

    LpgStatesList({
        required this.stateId,
        required this.stateName,
    });

    factory LpgStatesList.fromJson(Map<String, dynamic> json) => LpgStatesList(
        stateId: json["state_id"],
        stateName: json["state_name"],
    );

    Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
    };
}
