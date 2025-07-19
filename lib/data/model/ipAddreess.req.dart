class IpAddressRequest {
  String ipAddress;

  IpAddressRequest({required this.ipAddress});

  Map<String, dynamic> toJson() {
    return {
      "ip_address": ipAddress,
    };
  }
}
