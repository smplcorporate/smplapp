// To parse this JSON data, do
//
//     final distrcBodyRequest = distrcBodyRequestFromJson(jsonString);

import 'dart:convert';

DistrcBodyRequest distrcBodyRequestFromJson(String str) => DistrcBodyRequest.fromJson(json.decode(str));

String distrcBodyRequestToJson(DistrcBodyRequest data) => json.encode(data.toJson());

class DistrcBodyRequest {
    String stateId;

    DistrcBodyRequest({
        required this.stateId,
    });

    factory DistrcBodyRequest.fromJson(Map<String, dynamic> json) => DistrcBodyRequest(
        stateId: json["state_id"],
    );

    Map<String, dynamic> toJson() => {
        "state_id": stateId,
    };
}
