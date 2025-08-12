// To parse this JSON data, do
//
//     final ticketDetailsResponse = ticketDetailsResponseFromJson(jsonString);

import 'dart:convert';

TicketDetailsResponse ticketDetailsResponseFromJson(String str) => TicketDetailsResponse.fromJson(json.decode(str));

String ticketDetailsResponseToJson(TicketDetailsResponse data) => json.encode(data.toJson());

class TicketDetailsResponse {
    bool status;
    String statusDesc;
    List<TicketDetail> ticketDetails;

    TicketDetailsResponse({
        required this.status,
        required this.statusDesc,
        required this.ticketDetails,
    });

    factory TicketDetailsResponse.fromJson(Map<String, dynamic> json) => TicketDetailsResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        ticketDetails: List<TicketDetail>.from(json["ticket_details"].map((x) => TicketDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "ticket_details": List<dynamic>.from(ticketDetails.map((x) => x.toJson())),
    };
}

class TicketDetail {
    String ticketId;
    String subject;
    String companyPhoto;
    String memberPhoto;
    List<ChatList> chatList;

    TicketDetail({
        required this.ticketId,
        required this.subject,
        required this.companyPhoto,
        required this.memberPhoto,
        required this.chatList,
    });

    factory TicketDetail.fromJson(Map<String, dynamic> json) => TicketDetail(
        ticketId: json["ticket_id"],
        subject: json["subject"],
        companyPhoto: json["company_photo"],
        memberPhoto: json["member_photo"],
        chatList: List<ChatList>.from(json["chat_list"].map((x) => ChatList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
        "subject": subject,
        "company_photo": companyPhoto,
        "member_photo": memberPhoto,
        "chat_list": List<dynamic>.from(chatList.map((x) => x.toJson())),
    };
}

class ChatList {
    String description;
    String dateSupport;
    String replyBy;

    ChatList({
        required this.description,
        required this.dateSupport,
        required this.replyBy,
    });

    factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
        description: json["description"],
        dateSupport: json["date_support"],
        replyBy: json["reply_by"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "date_support": dateSupport,
        "reply_by": replyBy,
    };
}
