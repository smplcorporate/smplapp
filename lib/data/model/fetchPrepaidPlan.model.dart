class RechargeRequestModel {
  final String ipAddress;
  final String macAddress;
  final String latitude;
  final String longitude;
  final String billerCode;
  final String billerName;
  final String? circleCode; // Optional, mandatory only in specific cases
  final String param1;

  RechargeRequestModel({
    required this.ipAddress,
    required this.macAddress,
    required this.latitude,
    required this.longitude,
    required this.billerCode,
    required this.billerName,
    this.circleCode, // Nullable as it's conditionally mandatory
    required this.param1,
  });

  // Optional: Add a factory method or constructor from JSON if needed
  factory RechargeRequestModel.fromJson(Map<String, dynamic> json) {
    return RechargeRequestModel(
      ipAddress: json['ip_address'] as String,
      macAddress: json['mac_address'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      billerCode: json['biller_code'] as String,
      billerName: json['biller_name'] as String,
      circleCode: json['circle_code'] as String?, // Nullable
      param1: json['param1'] as String,
    );
  }

  // Optional: Convert to JSON for API posting
  Map<String, dynamic> toJson() {
    return {
      'ip_address': ipAddress,
      'mac_address': macAddress,
      'latitude': latitude,
      'longitude': longitude,
      'biller_code': billerCode,
      'biller_name': billerName,
      'circle_code': circleCode, // Will be null if not provided
      'param1': param1,
    };
  }
}