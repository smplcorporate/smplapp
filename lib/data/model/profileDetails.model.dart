// To parse this JSON data, do
//
//     final profileDetailsmodel = profileDetailsmodelFromJson(jsonString);

import 'dart:convert';

ProfileDetailsmodel profileDetailsmodelFromJson(String str) => ProfileDetailsmodel.fromJson(json.decode(str));

String profileDetailsmodelToJson(ProfileDetailsmodel data) => json.encode(data.toJson());

class ProfileDetailsmodel {
    bool status;
    String statusDesc;
    bool editAllow;
    UserDetails userDetails;
    StateDetails stateDetails;
    DistrictDetails districtDetails;
    TehsilDetails tehsilDetails;

    ProfileDetailsmodel({
        required this.status,
        required this.statusDesc,
        required this.editAllow,
        required this.userDetails,
        required this.stateDetails,
        required this.districtDetails,
        required this.tehsilDetails,
    });

    factory ProfileDetailsmodel.fromJson(Map<String, dynamic> json) => ProfileDetailsmodel(
        status: json["status"],
        statusDesc: json["status_desc"],
        editAllow: json["edit_allow"],
        userDetails: UserDetails.fromJson(json["user_details"]),
        stateDetails: StateDetails.fromJson(json["state_details"]),
        districtDetails: DistrictDetails.fromJson(json["district_details"]),
        tehsilDetails: TehsilDetails.fromJson(json["tehsil_details"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "edit_allow": editAllow,
        "user_details": userDetails.toJson(),
        "state_details": stateDetails.toJson(),
        "district_details": districtDetails.toJson(),
        "tehsil_details": tehsilDetails.toJson(),
    };
}

class DistrictDetails {
    int districtId;
    String districtName;

    DistrictDetails({
        required this.districtId,
        required this.districtName,
    });

    factory DistrictDetails.fromJson(Map<String, dynamic> json) => DistrictDetails(
        districtId: json["district_id"],
        districtName: json["district_name"],
    );

    Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
    };
}

class StateDetails {
    int stateId;
    String stateName;

    StateDetails({
        required this.stateId,
        required this.stateName,
    });

    factory StateDetails.fromJson(Map<String, dynamic> json) => StateDetails(
        stateId: json["state_id"],
        stateName: json["state_name"],
    );

    Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
    };
}

class TehsilDetails {
    int tehsilId;
    String tehsilName;

    TehsilDetails({
        required this.tehsilId,
        required this.tehsilName,
    });

    factory TehsilDetails.fromJson(Map<String, dynamic> json) => TehsilDetails(
        tehsilId: json["tehsil_id"],
        tehsilName: json["tehsil_name"],
    );

    Map<String, dynamic> toJson() => {
        "tehsil_id": tehsilId,
        "tehsil_name": tehsilName,
    };
}

class UserDetails {
    String uniqueId;
    String dateOfRegister;
    String firstName;
    String lastName;
    String fatherName;
    String dateOfBirth;
    String gender;
    String mobileNo;
    String emailId;
    String aadhaarNo;
    String panNo;
    String gstinNo;
    String address;
    String pinCode;
    String kycStatus;
    String userRole;
    String photo;

    UserDetails({
        required this.uniqueId,
        required this.dateOfRegister,
        required this.firstName,
        required this.lastName,
        required this.fatherName,
        required this.dateOfBirth,
        required this.gender,
        required this.mobileNo,
        required this.emailId,
        required this.aadhaarNo,
        required this.panNo,
        required this.gstinNo,
        required this.address,
        required this.pinCode,
        required this.kycStatus,
        required this.userRole,
        required this.photo,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        uniqueId: json["unique_id"],
        dateOfRegister: json["date_of_register"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fatherName: json["father_name"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        mobileNo: json["mobile_no"],
        emailId: json["email_id"],
        aadhaarNo: json["aadhaar_no"],
        panNo: json["pan_no"],
        gstinNo: json["gstin_no"],
        address: json["address"],
        pinCode: json["pin_code"],
        kycStatus: json["kyc_status"],
        userRole: json["user_role"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "unique_id": uniqueId,
        "date_of_register": dateOfRegister,
        "first_name": firstName,
        "last_name": lastName,
        "father_name": fatherName,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "mobile_no": mobileNo,
        "email_id": emailId,
        "aadhaar_no": aadhaarNo,
        "pan_no": panNo,
        "gstin_no": gstinNo,
        "address": address,
        "pin_code": pinCode,
        "kyc_status": kycStatus,
        "user_role": userRole,
        "photo": photo,
    };
}
