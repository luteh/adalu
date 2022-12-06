import 'package:flutter_rekret_ecommerce/data/model/response/address/district.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/checkout/courier.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/checkout/service_courier.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/product_model.dart';

class OrderPlaceModel {
  CustomerInfo _customerInfo;
  List<Cart> _cart;
  String _paymentMethod;
  double _discount;

  Courier _courier;
  ServiceCourier _serviceCourier;
  String _districtId;

  OrderPlaceModel(
    CustomerInfo customerInfo,
    List<Cart> cart,
    String paymentMethod,
    double discount,
    Courier courier,
    ServiceCourier serviceCourier,
    String districtId,
  ) {
    this._customerInfo = customerInfo;
    this._cart = cart;
    this._paymentMethod = paymentMethod;
    this._discount = discount;
    this._courier = courier;
    this._serviceCourier = serviceCourier;
    this._districtId = districtId;
  }

  OrderPlaceModel copyWith({
    CustomerInfo customerInfo,
    List<Cart> cart,
    String paymentMethod,
    double discount,
    Courier courier,
    ServiceCourier serviceCourier,
    String districtId,
  }) {
    return OrderPlaceModel(
      customerInfo ?? this._customerInfo,
      cart ?? this.cart,
      paymentMethod ?? this.paymentMethod,
      discount ?? this.discount,
      courier ?? this.courier,
      serviceCourier ?? this.serviceCourier,
      districtId ?? this.districtId,
    );
  }

  CustomerInfo get customerInfo => _customerInfo;
  List<Cart> get cart => _cart;
  String get paymentMethod => _paymentMethod;
  double get discount => _discount;
  Courier get courier => _courier;
  ServiceCourier get serviceCourier => _serviceCourier;
  String get districtId => _districtId;

  OrderPlaceModel.fromJson(Map<String, dynamic> json) {
    _customerInfo = json['customer_info'] != null
        ? new CustomerInfo.fromJson(json['customer_info'])
        : null;
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart.add(new Cart.fromJson(v));
      });
    }
    _paymentMethod = json['payment_method'];
    _discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._customerInfo != null) {
      data['customer_info'] = this._customerInfo.toJson();
    }
    if (this._cart != null) {
      data['cart'] = this._cart.map((v) => v.toJson()).toList();
    }
    data['payment_method'] = 'Ipaymu';
    data['discount'] = this._discount;
    return data;
  }
}

class CustomerInfo {
  String _addressId;
  String _shippingAddress;

  CustomerInfo(String addressId, String shippingAddress) {
    this._addressId = addressId;
    this._shippingAddress = shippingAddress;
  }

  String get addressId => _addressId;
  String get shippingAddress => _shippingAddress;

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    _addressId = json['address_id'];
    _shippingAddress = json['shipping_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this._addressId;
    data['shipping_address'] = this._shippingAddress;
    return data;
  }
}

class Cart {
  String _id;
  double _tax;
  int _quantity;
  double _price;
  double _discount;
  String _discountType;
  int _shippingMethodId;
  String _variant;
  List<Variation> _variation;
  double _shippingCost;

  Cart copyWith({
    String id,
    double tax,
    int quantity,
    double price,
    double discount,
    String discountType,
    int shippingMethodId,
    String variant,
    List<Variation> variation,
    double shippingCost,
  }) {
    return Cart(
      id ?? this._id,
      tax ?? this._tax,
      quantity ?? this._quantity,
      price ?? this._price,
      discount ?? this._discount,
      discountType ?? this._discountType,
      shippingMethodId ?? this._shippingMethodId,
      variant ?? this._variant,
      variation ?? this._variation,
      shippingCost ?? this._shippingCost,
    );
  }

  Cart(
    String id,
    double tax,
    int quantity,
    double price,
    double discount,
    String discountType,
    int shippingMethodId,
    String variant,
    List<Variation> variation,
    double shippingCost,
  ) {
    this._id = id;
    this._tax = tax;
    this._quantity = quantity;
    this._price = price;
    this._discount = discount;
    this._discountType = discountType;
    this._shippingMethodId = shippingMethodId;
    this._variant = variant;
    this._variation = variation;
    this._shippingCost = shippingCost;
  }

  String get id => _id;
  double get tax => _tax;
  int get quantity => _quantity;
  double get price => _price;
  double get discount => _discount;
  String get discountType => _discountType;
  int get shippingMethodId => _shippingMethodId;
  String get variant => _variant;
  List<Variation> get variation => _variation;
  double get shippingCost => _shippingCost;

  Cart.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _tax = json['tax'];
    _quantity = json['quantity'];
    _price = json['price'];
    _discount = json['discount'];
    _discountType = json['discount_type'];
    _shippingMethodId = json['shipping_method_id'];
    _variant = json['variant'];
    if (json['variations'] != null) {
      _variation = [];
      json['variations'].forEach((v) {
        _variation.add(new Variation.fromJson(v));
      });
    }
    _shippingCost = json['shipping_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['tax'] = this._tax;
    data['quantity'] = this._quantity;
    data['price'] = this._price;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['shipping_method_id'] = this._shippingMethodId;
    data['variant'] = this._variant;
    if (this._variation != null) {
      if (this._variation.first != null) {
        data['variations'] = this._variation.first.toJson();
      } else {
        data['variations'] = {};
      }
    }
    data['shipping_cost'] = this._shippingCost;
    return data;
  }
}
