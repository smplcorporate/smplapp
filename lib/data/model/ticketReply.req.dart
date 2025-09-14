// Request Model
class TicketReplyRequest {
  final String ipAddress;
  final String ticketId;
  final String replyMessage;

  TicketReplyRequest({
    required this.ipAddress,
    required this.ticketId,
    required this.replyMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      "ip_address": ipAddress,
      "ticket_id": ticketId,
      "reply_message": replyMessage,
    };
  }
}

// Response Model
class TicketReplyResponse {
  final bool status;
  final String statusDesc;
  final String ticketId;

  TicketReplyResponse({
    required this.status,
    required this.statusDesc,
    required this.ticketId,
  });

  factory TicketReplyResponse.fromJson(Map<String, dynamic> json) {
    return TicketReplyResponse(
      status: json["Status"] ?? false,
      statusDesc: json["status_desc"] ?? "",
      ticketId: json["ticket_id"] ?? "",
    );
  }
}
