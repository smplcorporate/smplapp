class PaymentRequest {
  final String ipAddress;
  final String macAddress;
  final String latitude;
  final String longitude;
  final String billerCode;
  final String billerName;
  final String? circleCode; // optional
  final String param1;
  final String? param2; // optional
  final String transAmount;
  final String? couponCode; // optional
  final String userMpin;

  PaymentRequest({
    required this.ipAddress,
    required this.macAddress,
    required this.latitude,
    required this.longitude,
    required this.billerCode,
    required this.billerName,
    this.circleCode,
    required this.param1,
    this.param2,
    required this.transAmount,
    this.couponCode,
    required this.userMpin,
  });

  Map<String, dynamic> toJson() {
    return {
      "ip_address": ipAddress,
      "mac_address": macAddress,
      "latitude": latitude,
      "longitude": longitude,
      "biller_code": billerCode,
      "biller_name": billerName,
      "circle_code": circleCode,
      "param1": param1,
      "param2": param2,
      "trans_amount": transAmount,
      "coupon_code": couponCode,
      "user_mpin": userMpin,
    };
  }

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return PaymentRequest(
      ipAddress: json["ip_address"],
      macAddress: json["mac_address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      billerCode: json["biller_code"],
      billerName: json["biller_name"],
      circleCode: json["circle_code"],
      param1: json["param1"],
      param2: json["param2"],
      transAmount: json["trans_amount"],
      couponCode: json["coupon_code"],
      userMpin: json["user_mpin"],
    );
  }
}
