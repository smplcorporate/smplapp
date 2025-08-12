// To parse this JSON data, do
//
//     final ticketDetailsRequest = ticketDetailsRequestFromJson(jsonString);

import 'dart:convert';

TicketDetailsRequest ticketDetailsRequestFromJson(String str) => TicketDetailsRequest.fromJson(json.decode(str));

String ticketDetailsRequestToJson(TicketDetailsRequest data) => json.encode(data.toJson());

class TicketDetailsRequest {
    String ticketId;

    TicketDetailsRequest({
        required this.ticketId,
    });

    factory TicketDetailsRequest.fromJson(Map<String, dynamic> json) => TicketDetailsRequest(
        ticketId: json["ticket_id"],
    );

    Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
    };
}
