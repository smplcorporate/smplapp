class PasswordChangeResponse {
  bool status;
  String statusDesc;

  PasswordChangeResponse({
    required this.status,
    required this.statusDesc,
  });

  factory PasswordChangeResponse.fromJson(Map<String, dynamic> json) {
    return PasswordChangeResponse(
      status: json['status'],
      statusDesc: json['status_desc'],
    );
  }
}
