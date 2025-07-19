// To parse this JSON data, do
//
//     final orderDetailsRes = orderDetailsResFromJson(jsonString);

import 'dart:convert';

OrderDetailsRes orderDetailsResFromJson(String str) => OrderDetailsRes.fromJson(json.decode(str));

String orderDetailsResToJson(OrderDetailsRes data) => json.encode(data.toJson());

class OrderDetailsRes {
    bool status;
    String statusDesc;
    OrderDetails orderDetails;
    BankTransIds bankTransIds;
    ParamDetails paramDetails;
    bool isbillDetails;
    BillDetails billDetails;
    bool ischarges;
    ChargesDetails chargesDetails;
    bool iscommission;
    CommissionDetails commissionDetails;
    bool iscoupon;
    CouponDetails couponDetails;

    OrderDetailsRes({
        required this.status,
        required this.statusDesc,
        required this.orderDetails,
        required this.bankTransIds,
        required this.paramDetails,
        required this.isbillDetails,
        required this.billDetails,
        required this.ischarges,
        required this.chargesDetails,
        required this.iscommission,
        required this.commissionDetails,
        required this.iscoupon,
        required this.couponDetails,
    });

    factory OrderDetailsRes.fromJson(Map<String, dynamic> json) => OrderDetailsRes(
        status: json["status"],
        statusDesc: json["status_desc"],
        orderDetails: OrderDetails.fromJson(json["order_details"]),
        bankTransIds: BankTransIds.fromJson(json["bank_trans_ids"]),
        paramDetails: ParamDetails.fromJson(json["param_details"]),
        isbillDetails: json["isbill_details"],
        billDetails: BillDetails.fromJson(json["bill_details"]),
        ischarges: json["ischarges"],
        chargesDetails: ChargesDetails.fromJson(json["charges_details"]),
        iscommission: json["iscommission"],
        commissionDetails: CommissionDetails.fromJson(json["commission_details"]),
        iscoupon: json["iscoupon"],
        couponDetails: CouponDetails.fromJson(json["coupon_details"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "order_details": orderDetails.toJson(),
        "bank_trans_ids": bankTransIds.toJson(),
        "param_details": paramDetails.toJson(),
        "isbill_details": isbillDetails,
        "bill_details": billDetails.toJson(),
        "ischarges": ischarges,
        "charges_details": chargesDetails.toJson(),
        "iscommission": iscommission,
        "commission_details": commissionDetails.toJson(),
        "iscoupon": iscoupon,
        "coupon_details": couponDetails.toJson(),
    };
}

class BankTransIds {
    String orderId;
    String operatorId;
    String referenceId;

    BankTransIds({
        required this.orderId,
        required this.operatorId,
        required this.referenceId,
    });

    factory BankTransIds.fromJson(Map<String, dynamic> json) => BankTransIds(
        orderId: json["order_id"],
        operatorId: json["operator_id"],
        referenceId: json["reference_id"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "operator_id": operatorId,
        "reference_id": referenceId,
    };
}

class BillDetails {
    String customerName;
    String customerMobile;
    dynamic billNo;
    String billDate;
    String billDuedate;

    BillDetails({
        required this.customerName,
        required this.customerMobile,
        required this.billNo,
        required this.billDate,
        required this.billDuedate,
    });

    factory BillDetails.fromJson(Map<String, dynamic> json) => BillDetails(
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        billNo: json["bill_no"],
        billDate: json["bill_date"],
        billDuedate: json["bill_duedate"]
    );

    Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "bill_no": billNo,
        "bill_date": billDate,
        "bill_duedate": billDate,
    };
}

class ChargesDetails {
    String chargesType;
    double chargesAmount;

    ChargesDetails({
        required this.chargesType,
        required this.chargesAmount,
    });

    factory ChargesDetails.fromJson(Map<String, dynamic> json) => ChargesDetails(
        chargesType: json["charges_type"],
        chargesAmount: json["charges_amount"],
    );

    Map<String, dynamic> toJson() => {
        "charges_type": chargesType,
        "charges_amount": chargesAmount,
    };
}

class CommissionDetails {
    String commissionType;
    double commissionAmount;

    CommissionDetails({
        required this.commissionType,
        required this.commissionAmount,
    });

    factory CommissionDetails.fromJson(Map<String, dynamic> json) => CommissionDetails(
        commissionType: json["commission_type"],
        commissionAmount: json["commission_amount"],
    );

    Map<String, dynamic> toJson() => {
        "commission_type": commissionType,
        "commission_amount": commissionAmount,
    };
}

class CouponDetails {
    String couponCode;
    double couponAmount;

    CouponDetails({
        required this.couponCode,
        required this.couponAmount,
    });

    factory CouponDetails.fromJson(Map<String, dynamic> json) => CouponDetails(
        couponCode: json["coupon_code"],
        couponAmount: json["coupon_amount"],
    );

    Map<String, dynamic> toJson() => {
        "coupon_code": couponCode,
        "coupon_amount": couponAmount,
    };
}

class OrderDetails {
    String transLogo;
    String transDate;
    String transId;
    double transAmount;
    String serviceType;
    String serviceProvider;
    String transStatus;
    String transRemark;
    String transReceiptUrl;
    String refundDate;

    OrderDetails({
        required this.transLogo,
        required this.transDate,
        required this.transId,
        required this.transAmount,
        required this.serviceType,
        required this.serviceProvider,
        required this.transStatus,
        required this.transRemark,
        required this.transReceiptUrl,
        required this.refundDate,
    });

    factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        transLogo: json["trans_logo"],
        transDate: json["trans_date"],
        transId: json["trans_id"],
        transAmount: json["trans_amount"],
        serviceType: json["service_type"],
        serviceProvider: json["service_provider"],
        transStatus: json["trans_status"],
        transRemark: json["trans_remark"],
        transReceiptUrl: json["trans_receipt_url"],
        refundDate: json["refund_date"],
    );

    Map<String, dynamic> toJson() => {
        "trans_logo": transLogo,
        "trans_date": transDate,
        "trans_id": transId,
        "trans_amount": transAmount,
        "service_type": serviceType,
        "service_provider": serviceProvider,
        "trans_status": transStatus,
        "trans_remark": transRemark,
        "trans_receipt_url": transReceiptUrl,
        "refund_date": refundDate,
    };
}

class ParamDetails {
    String param1;
    String param2;
    String param3;
    String param4;
    String param5;

    ParamDetails({
        required this.param1,
        required this.param2,
        required this.param3,
        required this.param4,
        required this.param5,
    });

    factory ParamDetails.fromJson(Map<String, dynamic> json) => ParamDetails(
        param1: json["param1"],
        param2: json["param2"],
        param3: json["param3"],
        param4: json["param4"],
        param5: json["param5"],
    );

    Map<String, dynamic> toJson() => {
        "param1": param1,
        "param2": param2,
        "param3": param3,
        "param4": param4,
        "param5": param5,
    };
}
