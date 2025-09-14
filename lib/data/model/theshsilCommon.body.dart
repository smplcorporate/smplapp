// To parse this JSON data, do
//
//     final thehSillCommonBody = thehSillCommonBodyFromJson(jsonString);

import 'dart:convert';

ThehSillCommonBody thehSillCommonBodyFromJson(String str) => ThehSillCommonBody.fromJson(json.decode(str));

String thehSillCommonBodyToJson(ThehSillCommonBody data) => json.encode(data.toJson());

class ThehSillCommonBody {
    int districtId;

    ThehSillCommonBody({
        required this.districtId,
    });

    factory ThehSillCommonBody.fromJson(Map<String, dynamic> json) => ThehSillCommonBody(
        districtId: json["district_id"],
    );

    Map<String, dynamic> toJson() => {
        "district_id": districtId,
    };
}
