class B2CAccountDetailsUpdateResponse {
  bool status;
  String statusDesc;

  B2CAccountDetailsUpdateResponse({
    required this.status,
    required this.statusDesc,
  });

  factory B2CAccountDetailsUpdateResponse.fromJson(Map<String, dynamic> json) {
    return B2CAccountDetailsUpdateResponse(
      status: json['status'],
      statusDesc: json['status_desc'],
    );
  }
}
