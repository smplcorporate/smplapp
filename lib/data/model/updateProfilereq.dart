class UserProfileUpdateReq {
  String ipAddress;
  String firstName;
  String lastName;
  String? fatherName;
  String gender;
  String dateOfBirth; // Format: DD/MM/YYYY
  String emailId;
  String aadhaarNo;
  String panNo;
  String? gstinNo;
  int stateId;
  int districtId;
  int tehsilId;
  String pinCode;
  String address;

  UserProfileUpdateReq({
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

  Map<String, dynamic> toJson() {
    return {
      "ip_address": ipAddress,
      "first_name": firstName,
      "last_name": lastName,
      if (fatherName != null) "father_name": fatherName,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "email_id": emailId,
      "aadhaar_no": aadhaarNo,
      "pan_no": panNo,
      if (gstinNo != null) "gstin_no": gstinNo,
      "state_id": stateId,
      "district_id": districtId,
      "tehsil_id": tehsilId,
      "pin_code": pinCode,
      "address": address,
    };
  }
}
