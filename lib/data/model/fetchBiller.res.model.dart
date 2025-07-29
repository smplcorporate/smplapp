import 'dart:convert';

FetchResponseModel fetchResponseModelFromJson(String str) =>
    FetchResponseModel.fromJson(json.decode(str));

String fetchResponseModelToJson(FetchResponseModel data) =>
    json.encode(data.toJson());

class FetchResponseModel {
  final bool status;
  final String statusDesc;
  final String billerType;
  final String billerName;
   String? billAmount;
  final String? customerName;
  final String billNo;
  final String dueDate;
  final String billDate;
  final String returnTransid;
  final String returnFetchid;
  final String returnBillid;

  FetchResponseModel({
    required this.status,
    required this.statusDesc,
    required this.billerType,
    required this.billerName,
    required this.billAmount,
    required this.customerName,
    required this.billNo,
    required this.dueDate,
    required this.billDate,
    required this.returnTransid,
    required this.returnFetchid,
    required this.returnBillid,
  });

  factory FetchResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchResponseModel(
      status: json["status"],
      statusDesc: json["status_desc"] ?? '',
      billerType: json["biller_type"] ?? '',
      billerName: json["biller_name"] ?? '',
      billAmount: json["bill_amount"]?.toString(),
      customerName: json["customer_name"],
      billNo: json["bill_no"] ?? '',
      dueDate: json["due_date"],
      billDate: json["bill_date"] ?? '',
      returnTransid: json["return_transid"] ?? '',
      returnFetchid: json["return_fetchid"] ?? '',
      returnBillid: json["return_billid"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_desc": statusDesc,
    "biller_type": billerType,
    "biller_name": billerName,
    "bill_amount": billAmount,
    "customer_name": customerName,
    "bill_no": billNo,
    "due_date": dueDate,
    "bill_date": billDate,
    "return_transid": returnTransid,
    "return_fetchid": returnFetchid,
    "return_billid": returnBillid,
  };
}
