class UserUpdateeModel {
  final String ipAddress; // Required
  final String firstName; // Min: 5, Max: 30, Required
  final String lastName; // Max: 30, Required
  final String? fatherName; // Max: 40, Optional
  final String gender; // M/F/O, Required
  final String dateOfBirth; // Format: DD/MM/YYYY, Required
  final String emailId; // Max: 50, Required
  final int aadhaarNo; // Fixed: 12 digits, Required
  final String panNo; // Fixed: 10, Required
  final String? gstinNo; // Max: 30, Optional
  final String stateId; // Required
  final String districtId; // Required
  final String tehsilId; // Required
  final int pinCode; // Fixed: 6, Required
  final String address;
 // Min: 10, Max: 200, Required

  UserUpdateeModel({
    required this.ipAddress,
    required this.firstName,
    required this.lastName,
    this.fatherName,
    required this.gender,
    required this.dateOfBirth,
    required this.emailId,
    required this.aadhaarNo,
    required this.panNo,
    this.gstinNo,
    required this.stateId,
    required this.districtId,
    required this.tehsilId,
    required this.pinCode,
    required this.address,
  
  });

  factory UserUpdateeModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateeModel(
      ipAddress: json['ip_address'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fatherName: json['father_name'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      emailId: json['email_id'],
      aadhaarNo: json['aadhaar_no'],
      panNo: json['pan_no'],
      gstinNo: json['gstin_no'],
      stateId: json['state_id'],
      districtId: json['district_id'],
      tehsilId: json['tehsil_id'],
      pinCode: json['pin_code'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip_address': ipAddress,
      'first_name': firstName,
      'last_name': lastName,
      'father_name': fatherName,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'email_id': emailId,
      'aadhaar_no': aadhaarNo,
      'pan_no': panNo,
      'gstin_no': gstinNo,
      'state_id': stateId,
      'district_id': districtId,
      'tehsil_id': tehsilId,
      'pin_code': pinCode,
      'address': address,
    };
  }
}
