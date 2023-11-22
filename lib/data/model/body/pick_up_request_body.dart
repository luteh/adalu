class PickUpRequestBody {
  int ticketId;
  int orderId;

  PickUpRequestBody(this.ticketId, this.orderId);

  PickUpRequestBody.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['order_id'] = this.orderId;
    return data;
  }
}
