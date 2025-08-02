// To parse this JSON data, do
//
//     final orderListResponse = orderListResponseFromJson(jsonString);

import 'dart:convert';

OrderListResponse orderListResponseFromJson(String str) => OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) => json.encode(data.toJson());

class OrderListResponse {
    bool status;
    String statusDesc;
    int success;
    int pending;
    int failed;
    List<OrdersList> ordersList;

    OrderListResponse({
        required this.status,
        required this.statusDesc,
        required this.success,
        required this.pending,
        required this.failed,
        required this.ordersList,
    });

    factory OrderListResponse.fromJson(Map<String, dynamic> json) => OrderListResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        success: json["success"],
        pending: json["pending"],
        failed: json["failed"],
        ordersList: List<OrdersList>.from(json["orders_list"].map((x) => OrdersList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "success": success,
        "pending": pending,
        "failed": failed,
        "orders_list": List<dynamic>.from(ordersList.map((x) => x.toJson())),
    };
}

class OrdersList {
    String transLogo;
    String transDate;
    String transId;
    String serviceProvider;
    String serviceAccount;
    int transAmount;
    String transStatus;

    OrdersList({
        required this.transLogo,
        required this.transDate,
        required this.transId,
        required this.serviceProvider,
        required this.serviceAccount,
        required this.transAmount,
        required this.transStatus,
    });

    factory OrdersList.fromJson(Map<String, dynamic> json) => OrdersList(
        transLogo: json["trans_logo"],
        transDate: json["trans_date"],
        transId: json["trans_id"],
        serviceProvider: json["service_provider"],
        serviceAccount: json["service_account"],
        transAmount: json["trans_amount"],
        transStatus: json["trans_status"],
    );

    Map<String, dynamic> toJson() => {
        "trans_logo": transLogo,
        "trans_date": transDate,
        "trans_id": transId,
        "service_provider": serviceProvider,
        "service_account": serviceAccount,
        "trans_amount": transAmount,
        "trans_status": transStatus,
    };
}
