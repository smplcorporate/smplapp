// To parse this JSON data, do
//
//     final kycListmodel = kycListmodelFromJson(jsonString);

import 'dart:convert';

KycListmodel kycListmodelFromJson(String str) => KycListmodel.fromJson(json.decode(str));

String kycListmodelToJson(KycListmodel data) => json.encode(data.toJson());

class KycListmodel {
    bool status;
    String statusDesc;
    List<RequireDocsList> requireDocsList;
    List<KycList> kycList;
    List<dynamic> instructionsList;

    KycListmodel({
        required this.status,
        required this.statusDesc,
        required this.requireDocsList,
        required this.kycList,
        required this.instructionsList,
    });

    factory KycListmodel.fromJson(Map<String, dynamic> json) => KycListmodel(
        status: json["status"],
        statusDesc: json["status_desc"],
        requireDocsList: List<RequireDocsList>.from(json["require_docs_list"].map((x) => RequireDocsList.fromJson(x))),
        kycList: List<KycList>.from(json["kyc_list"].map((x) => KycList.fromJson(x))),
        instructionsList: List<dynamic>.from(json["instructions_list"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "require_docs_list": List<dynamic>.from(requireDocsList.map((x) => x.toJson())),
        "kyc_list": List<dynamic>.from(kycList.map((x) => x.toJson())),
        "instructions_list": List<dynamic>.from(instructionsList.map((x) => x)),
    };
}

class KycList {
    int kycId;
    String documentType;
    String uploadDate;
    String verifyDate;
    String verifyStatus;
    String remarks;
    String kycUrl;

    KycList({
        required this.kycId,
        required this.documentType,
        required this.uploadDate,
        required this.verifyDate,
        required this.verifyStatus,
        required this.remarks,
        required this.kycUrl,
    });

    factory KycList.fromJson(Map<String, dynamic> json) => KycList(
        kycId: json["kyc_id"],
        documentType: json["document_type"],
        uploadDate: json["upload_date"],
        verifyDate: json["verify_date"],
        verifyStatus: json["verify_status"],
        remarks: json["remarks"],
        kycUrl: json["kyc_url"],
    );

    Map<String, dynamic> toJson() => {
        "kyc_id": kycId,
        "document_type": documentType,
        "upload_date": uploadDate,
        "verify_date": verifyDate,
        "verify_status": verifyStatus,
        "remarks": remarks,
        "kyc_url": kycUrl,
    };
}

class RequireDocsList {
    String documentId;
    String documentValue;

    RequireDocsList({
        required this.documentId,
        required this.documentValue,
    });

    factory RequireDocsList.fromJson(Map<String, dynamic> json) => RequireDocsList(
        documentId: json["document_id"],
        documentValue: json["document_value"],
    );

    Map<String, dynamic> toJson() => {
        "document_id": documentId,
        "document_value": documentValue,
    };
}
