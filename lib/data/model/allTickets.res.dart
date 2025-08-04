
import 'dart:convert';

SupportLoadResponse supportLoadResponseFromJson(String str) => SupportLoadResponse.fromJson(json.decode(str));

String supportLoadResponseToJson(SupportLoadResponse data) => json.encode(data.toJson());

class SupportLoadResponse {
    bool status;
    String statusDesc;
    int ticketsAll;
    int ticketsPending;
    int ticketsClosed;
    List<TicketsList> ticketsList;

    SupportLoadResponse({
        required this.status,
        required this.statusDesc,
        required this.ticketsAll,
        required this.ticketsPending,
        required this.ticketsClosed,
        required this.ticketsList,
    });

    factory SupportLoadResponse.fromJson(Map<String, dynamic> json) => SupportLoadResponse(
        status: json["status"],
        statusDesc: json["status_desc"],
        ticketsAll: json["tickets_all"],
        ticketsPending: json["tickets_pending"],
        ticketsClosed: json["tickets_closed"],
        ticketsList: List<TicketsList>.from(json["tickets_list"].map((x) => TicketsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_desc": statusDesc,
        "tickets_all": ticketsAll,
        "tickets_pending": ticketsPending,
        "tickets_closed": ticketsClosed,
        "tickets_list": List<dynamic>.from(ticketsList.map((x) => x.toJson())),
    };
}

class TicketsList {
    String ticketId;
    String subject;
    String status;
    String dateSupport;
    String dateClosed;

    TicketsList({
        required this.ticketId,
        required this.subject,
        required this.status,
        required this.dateSupport,
        required this.dateClosed,
    });

    factory TicketsList.fromJson(Map<String, dynamic> json) => TicketsList(
        ticketId: json["ticket_id"],
        subject: json["subject"],
        status: json["status"],
        dateSupport: json["date_support"],
        dateClosed: json["date_closed"],
    );

    Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
        "subject": subject,
        "status": status,
        "date_support": dateSupport,
        "date_closed": dateClosed,
    };
}
