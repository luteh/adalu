class SupportTicketCommentBody {
  int ticketId;
  String comment;

  SupportTicketCommentBody(this.ticketId, this.comment);

  SupportTicketCommentBody.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['comment'] = this.comment;
    return data;
  }
}
