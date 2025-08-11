// To parse this JSON data, do
//
//     final offerListmodelResponse = offerListmodelResponseFromJson(jsonString);

import 'dart:convert';

OfferListmodelResponse offerListmodelResponseFromJson(String str) => OfferListmodelResponse.fromJson(json.decode(str));

String offerListmodelResponseToJson(OfferListmodelResponse data) => json.encode(data.toJson());

class OfferListmodelResponse {
    bool status;
    String statusDesc;
    List<OffersList> offersList;

    OfferListmodelResponse({
        required this.status,
        required this.statusDesc,
        required this.offersList,
    });

    factory OfferListmodelResponse.fromJson(Map<String, dynamic> json) => OfferListmodelResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        offersList: List<OffersList>.from(json["offers_list"].map((x) => OffersList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "offers_list": List<dynamic>.from(offersList.map((x) => x.toJson())),
    };
}

class OffersList {
    int offerId;
    String serviceName;
    String offerTitle;
    String validTo;
    String offerImage;

    OffersList({
        required this.offerId,
        required this.serviceName,
        required this.offerTitle,
        required this.validTo,
        required this.offerImage,
    });

    factory OffersList.fromJson(Map<String, dynamic> json) => OffersList(
        offerId: json["offer_id"],
        serviceName: json["service_name"],
        offerTitle: json["offer_title"],
        validTo: json["valid_to"],
        offerImage: json["offer_image"],
    );

    Map<String, dynamic> toJson() => {
        "offer_id": offerId,
        "service_name": serviceName,
        "offer_title": offerTitle,
        "valid_to": validTo,
        "offer_image": offerImage,
    };
}
