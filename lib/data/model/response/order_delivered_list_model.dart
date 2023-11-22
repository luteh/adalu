import 'dart:convert';

import 'package:flutter_rekret_ecommerce/data/model/response/delivered_product_detail_model.dart';

class OrderDeliveredListModel {
  int status;
  Message message;
  int data;

  OrderDeliveredListModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderDeliveredListModel.fromRawJson(String str) =>
      OrderDeliveredListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDeliveredListModel.fromJson(Map<String, dynamic> json) =>
      OrderDeliveredListModel(
        status: json["status"],
        message: Message.fromJson(json["message"]),
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
        "data": data,
      };
}

class Message {
  ProductData the100095;
  List<int> listorderid;

  Message({
    this.the100095,
    this.listorderid,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        the100095: ProductData.fromJson(json["100095"]),
        listorderid: List<int>.from(json["listorderid"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "100095": the100095.toJson(),
        "listorderid": List<dynamic>.from(listorderid.map((x) => x)),
      };
}

class ProductData {
  OrderProductData data;
  List<ListProduct> listProduct;

  ProductData({
    this.data,
    this.listProduct,
  });

  factory ProductData.fromRawJson(String str) =>
      ProductData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        data: OrderProductData.fromJson(json["data"]),
        listProduct: List<ListProduct>.from(
            json["list_product"].map((x) => ListProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "list_product": List<dynamic>.from(listProduct.map((x) => x.toJson())),
      };
}

class OrderProductData {
  int id;
  int customerId;
  String customerType;
  String paymentStatus;
  String orderStatus;
  String paymentMethod;
  String transactionRef;
  int orderAmount;
  String shippingAddress;
  String shippingCourier;
  String shippingCode;
  String shippingName;
  String shippingFee;
  String insuranceFee;
  String createdAt;
  String updatedAt;
  int discountAmount;
  String discountType;

  OrderProductData({
    this.id,
    this.customerId,
    this.customerType,
    this.paymentStatus,
    this.orderStatus,
    this.paymentMethod,
    this.transactionRef,
    this.orderAmount,
    this.shippingAddress,
    this.shippingCourier,
    this.shippingCode,
    this.shippingName,
    this.shippingFee,
    this.insuranceFee,
    this.createdAt,
    this.updatedAt,
    this.discountAmount,
    this.discountType,
  });

  factory OrderProductData.fromRawJson(String str) =>
      OrderProductData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderProductData.fromJson(Map<String, dynamic> json) =>
      OrderProductData(
        id: json["id"],
        customerId: json["customer_id"],
        customerType: json["customer_type"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        paymentMethod: json["payment_method"],
        transactionRef: json["transaction_ref"],
        orderAmount: json["order_amount"],
        shippingAddress: json["shipping_address"],
        shippingCourier: json["shipping_courier"],
        shippingCode: json["shipping_code"],
        shippingName: json["shipping_name"],
        shippingFee: json["shipping_fee"],
        insuranceFee: json["insurance_fee"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        discountAmount: json["discount_amount"],
        discountType: json["discount_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "customer_type": customerType,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "payment_method": paymentMethod,
        "transaction_ref": transactionRef,
        "order_amount": orderAmount,
        "shipping_address": shippingAddress,
        "shipping_courier": shippingCourier,
        "shipping_code": shippingCode,
        "shipping_name": shippingName,
        "shipping_fee": shippingFee,
        "insurance_fee": insuranceFee,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "discount_amount": discountAmount,
        "discount_type": discountType,
      };
}

class ListProduct {
  int id;
  int orderId;
  int productId;
  int sellerId;
  DeliveredProductDetailModel productDetails;
  int qty;
  int price;
  double tax;
  int discount;
  String deliveryStatus;
  String paymentStatus;
  String createdAt;
  String updatedAt;
  dynamic shippingMethodId;
  String shippingCourier;
  String shippingCode;
  String shippingName;
  String shippingFee;
  String variant;
  String variation;
  String discountType;
  int isStockDecreased;

  ListProduct({
    this.id,
    this.orderId,
    this.productId,
    this.sellerId,
    this.productDetails,
    this.qty,
    this.price,
    this.tax,
    this.discount,
    this.deliveryStatus,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.shippingMethodId,
    this.shippingCourier,
    this.shippingCode,
    this.shippingName,
    this.shippingFee,
    this.variant,
    this.variation,
    this.discountType,
    this.isStockDecreased,
  });

  factory ListProduct.fromRawJson(String str) =>
      ListProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListProduct.fromJson(Map<String, dynamic> json) => ListProduct(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        sellerId: json["seller_id"],
        productDetails:
            DeliveredProductDetailModel.fromRawJson(json["product_details"]),
        qty: json["qty"],
        price: json["price"],
        tax: json["tax"].toDouble(),
        discount: json["discount"],
        deliveryStatus: json["delivery_status"],
        paymentStatus: json["payment_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        shippingMethodId: json["shipping_method_id"],
        shippingCourier: json["shipping_courier"],
        shippingCode: json["shipping_code"],
        shippingName: json["shipping_name"],
        shippingFee: json["shipping_fee"],
        variant: json["variant"],
        variation: json["variation"],
        discountType: json["discount_type"],
        isStockDecreased: json["is_stock_decreased"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "seller_id": sellerId,
        "product_details": productDetails,
        "qty": qty,
        "price": price,
        "tax": tax,
        "discount": discount,
        "delivery_status": deliveryStatus,
        "payment_status": paymentStatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "shipping_method_id": shippingMethodId,
        "shipping_courier": shippingCourier,
        "shipping_code": shippingCode,
        "shipping_name": shippingName,
        "shipping_fee": shippingFee,
        "variant": variant,
        "variation": variation,
        "discount_type": discountType,
        "is_stock_decreased": isStockDecreased,
      };

  @override
  String toString() {
    return productDetails.name;
  }
}
