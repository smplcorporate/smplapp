// To parse this JSON data, do
//
//     final distrubuterBodyReq = distrubuterBodyReqFromJson(jsonString);

import 'dart:convert';

DistrubuterBodyReq distrubuterBodyReqFromJson(String str) => DistrubuterBodyReq.fromJson(json.decode(str));

String distrubuterBodyReqToJson(DistrubuterBodyReq data) => json.encode(data.toJson());

class DistrubuterBodyReq {
    String stateId;
    String districtId;

    DistrubuterBodyReq({
        required this.stateId,
        required this.districtId,
    });

    factory DistrubuterBodyReq.fromJson(Map<String, dynamic> json) => DistrubuterBodyReq(
        stateId: json["state_id"],
        districtId: json["district_id"],
    );

    Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "district_id": districtId,
    };
}
