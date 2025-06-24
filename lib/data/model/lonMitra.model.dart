import 'dart:io';

class LoanmitraFormModel {
  final String ipAddress;
  final String macAddress;
  final String latitude;
  final String longitude;
  final String serviceType;
  final String serviceProviderCode;
  final String customerName;
  final String customerMobile;
  final String customerEmail;
  final String customerDob;
  final String customerMonthlyIncome;
  final String customerAddress;
  final String aadhaarNo;
  final String panNo;
  final File? aadhaarNoFile;
  final File? panNoFile;
  final String userMpin;

  LoanmitraFormModel({
    this.ipAddress = '',
    this.macAddress = '',
    this.latitude = '',
    this.longitude = '',
    this.serviceType = '',
    this.serviceProviderCode = '',
    this.customerName = '',
    this.customerMobile = '',
    this.customerEmail = '',
    this.customerDob = '',
    this.customerMonthlyIncome = '',
    this.customerAddress = '',
    this.aadhaarNo = '',
    this.panNo = '',
    this.aadhaarNoFile,
    this.panNoFile,
    this.userMpin = '',
  });

  LoanmitraFormModel copyWith({
    String? ipAddress,
    String? macAddress,
    String? latitude,
    String? longitude,
    String? serviceType,
    String? serviceProviderCode,
    String? customerName,
    String? customerMobile,
    String? customerEmail,
    String? customerDob,
    String? customerMonthlyIncome,
    String? customerAddress,
    String? aadhaarNo,
    String? panNo,
    File? aadhaarNoFile,
    File? panNoFile,
    String? userMpin,
  }) {
    return LoanmitraFormModel(
      ipAddress: ipAddress ?? this.ipAddress,
      macAddress: macAddress ?? this.macAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      serviceType: serviceType ?? this.serviceType,
      serviceProviderCode: serviceProviderCode ?? this.serviceProviderCode,
      customerName: customerName ?? this.customerName,
      customerMobile: customerMobile ?? this.customerMobile,
      customerEmail: customerEmail ?? this.customerEmail,
      customerDob: customerDob ?? this.customerDob,
      customerMonthlyIncome: customerMonthlyIncome ?? this.customerMonthlyIncome,
      customerAddress: customerAddress ?? this.customerAddress,
      aadhaarNo: aadhaarNo ?? this.aadhaarNo,
      panNo: panNo ?? this.panNo,
      aadhaarNoFile: aadhaarNoFile ?? this.aadhaarNoFile,
      panNoFile: panNoFile ?? this.panNoFile,
      userMpin: userMpin ?? this.userMpin,
    );
  }
}
