import 'dart:convert';

class AwbModel {
  int pickupOrdersId;
  int ordersId;
  String awbNo;
  String referenceNo;
  String originBranchCode;
  String destinationBranchCode;
  String tlcBranchCode;
  String msg;
  String createdAt;
  String updatedAt;

  AwbModel({
    this.pickupOrdersId,
    this.ordersId,
    this.awbNo,
    this.referenceNo,
    this.originBranchCode,
    this.destinationBranchCode,
    this.tlcBranchCode,
    this.msg,
    this.createdAt,
    this.updatedAt,
  });

  factory AwbModel.fromRawJson(String str) =>
      AwbModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AwbModel.fromJson(Map<String, dynamic> json) => AwbModel(
        pickupOrdersId: json["pickup_orders_id"],
        ordersId: json["orders_id"],
        awbNo: json["awb_no"],
        referenceNo: json["reference_no"],
        originBranchCode: json["origin_branch_code"],
        destinationBranchCode: json["destination_branch_code"],
        tlcBranchCode: json["tlc_branch_code"],
        msg: json["msg"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "pickup_orders_id": pickupOrdersId,
        "orders_id": ordersId,
        "awb_no": awbNo,
        "reference_no": referenceNo,
        "origin_branch_code": originBranchCode,
        "destination_branch_code": destinationBranchCode,
        "tlc_branch_code": tlcBranchCode,
        "msg": msg,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
