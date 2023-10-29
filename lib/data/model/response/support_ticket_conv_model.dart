import 'dart:convert';

class SupportTicketConvModel {
  int id;
  int supportTicketId;
  int adminId;
  String customerMessage;
  String adminMessage;
  int position;
  String createdAt;
  String updatedAt;

  SupportTicketConvModel({
    this.id,
    this.supportTicketId,
    this.adminId,
    this.customerMessage,
    this.adminMessage,
    this.position,
    this.createdAt,
    this.updatedAt,
  });

  bool get isMe => adminId == null;
  String get message => isMe ? customerMessage : adminMessage;

  factory SupportTicketConvModel.fromRawJson(String str) =>
      SupportTicketConvModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupportTicketConvModel.fromJson(Map<String, dynamic> json) =>
      SupportTicketConvModel(
        id: json["id"],
        supportTicketId: json["support_ticket_id"],
        adminId: json["admin_id"],
        customerMessage: json["customer_message"],
        adminMessage: json["admin_message"],
        position: json["position"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "support_ticket_id": supportTicketId,
        "admin_id": adminId,
        "customer_message": customerMessage,
        "admin_message": adminMessage,
        "position": position,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
