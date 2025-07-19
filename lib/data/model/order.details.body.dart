// To parse this JSON data, do
//
//     final getOrderDetailsBody = getOrderDetailsBodyFromJson(jsonString);

import 'dart:convert';

GetOrderDetailsBody getOrderDetailsBodyFromJson(String str) => GetOrderDetailsBody.fromJson(json.decode(str));

String getOrderDetailsBodyToJson(GetOrderDetailsBody data) => json.encode(data.toJson());

class GetOrderDetailsBody {
    String transId;

    GetOrderDetailsBody({
        required this.transId,
    });

    factory GetOrderDetailsBody.fromJson(Map<String, dynamic> json) => GetOrderDetailsBody(
        transId: json["trans_id"],
    );

    Map<String, dynamic> toJson() => {
        "trans_id": transId,
    };
}
