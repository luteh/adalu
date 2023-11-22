import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/provider/support_ticket_provider.dart';
import 'package:image_picker/image_picker.dart';

class SupportTicketReturnModel {
  final int orderId;
  final String type;
  final String priority;
  final String description;
  final XFile videoFile;
  final List<RefundProduct> products;

  SupportTicketReturnModel({
    @required this.orderId,
    @required this.type,
    @required this.priority,
    @required this.description,
    @required this.videoFile,
    @required this.products,
  });
}
