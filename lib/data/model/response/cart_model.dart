import 'package:flutter_rekret_ecommerce/data/model/response/product_model.dart';

class CartModel {
  int _id;
  String _image;
  String _name;
  String _seller;
  double _price;
  double _discountedPrice;
  int _quantity;
  int _maxQuantity;
  String _variant;
  Variation _variation;
  double _discount;
  String _discountType;
  double _tax;
  String _taxType;
  int _shippingMethodId;
  String _statusConfirmation;
  String _statusMsg;
  int _quantityConfirmed;

  CartModel(
    this._id,
    this._image,
    this._name,
    this._seller,
    this._price,
    this._discountedPrice,
    this._quantity,
    this._maxQuantity,
    this._variant,
    this._variation,
    this._discount,
    this._discountType,
    this._tax,
    this._taxType,
    this._shippingMethodId,
    this._statusConfirmation,
    this._statusMsg,
    this._quantityConfirmed,
  );

  String get variant => _variant;
  Variation get variation => _variation;
  // ignore: unnecessary_getters_setters
  int get quantity => _quantity;
  // ignore: unnecessary_getters_setters
  set quantity(int value) {
    _quantity = value;
  }

  int get maxQuantity => _maxQuantity;
  double get price => _price;
  double get discountedPrice => _discountedPrice;
  String get name => _name;
  String get seller => _seller;
  String get image => _image;
  int get id => _id;
  double get discount => _discount;
  String get discountType => _discountType;
  double get tax => _tax;
  String get taxType => _taxType;
  int get shippingMethodId => _shippingMethodId;
  String get statusConfirmation => _statusConfirmation;
  String get statusMsg => _statusMsg;
  int get quantityConfirmed => _quantityConfirmed;

  double getCalculationUnitPrice() {
    double calculate = this.discountedPrice;

    return calculate;
  }

  double getTaxPrice() {
    double calculate = this.discountedPrice;
    double taxPrice = 0;

    if (this.tax > 0) {
      taxPrice += ((tax / 100) * this.discountedPrice);

      return taxPrice;
    }

    return taxPrice;
  }

  double getPriceWithTax() {
    if (this.tax != null) {
      return this.price + (this.price * (this.tax / 100));
    }

    return this.price;
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _seller = json['seller'];
    _image = json['image'];
    _price = json['price'];
    _discountedPrice = json['discounted_price'];
    _quantity = json['quantity'];
    _maxQuantity = json['max_quantity'];
    _variant = json['variant'];
    _variation = json['variation'] != null
        ? Variation.fromJson(json['variation'])
        : null;
    _discount = json['discount'];
    _discountType = json['discount_type'];
    _tax = json['tax'];
    _taxType = json['tax_type'];
    _shippingMethodId = json['shipping_method_id'];
    _statusConfirmation = json['status_confirmation'];
    _statusMsg = json['status_msg'];
    _quantityConfirmed = json['quantity_confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['seller'] = this._seller;
    data['image'] = this._image;
    data['price'] = this._price;
    data['discounted_price'] = this._discountedPrice;
    data['quantity'] = this._quantity;
    data['max_quantity'] = this._maxQuantity;
    data['variant'] = this._variant;
    data['variation'] = this._variation;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['tax'] = this._tax;
    data['tax_type'] = this._taxType;
    data['shipping_method_id'] = this._shippingMethodId;
    data['status_confirmation'] = this._statusConfirmation;
    data['status_msg'] = this._statusMsg;
    data['quantity_confirmed'] = this._quantityConfirmed;
    return data;
  }
}
