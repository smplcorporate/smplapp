// To parse this JSON data, do
//
//     final stateListCommon = stateListCommonFromJson(jsonString);

import 'dart:convert';

StateListCommon stateListCommonFromJson(String str) => StateListCommon.fromJson(json.decode(str));

String stateListCommonToJson(StateListCommon data) => json.encode(data.toJson());

class StateListCommon {
    bool status;
    String statusDesc;
    List<StateList> stateList;

    StateListCommon({
        required this.status,
        required this.statusDesc,
        required this.stateList,
    });

    factory StateListCommon.fromJson(Map<String, dynamic> json) => StateListCommon(
        status: json["status"],
        statusDesc: json["status_desc"],
        stateList: List<StateList>.from(json["state_list"].map((x) => StateList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "state_list": List<dynamic>.from(stateList.map((x) => x.toJson())),
    };
}

class StateList {
    dynamic stateId;
    String stateName;

    StateList({
        required this.stateId,
        required this.stateName,
    });

    factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        stateId: json["state_id"],
        stateName: json["state_name"],
    );

    Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
    };
}
