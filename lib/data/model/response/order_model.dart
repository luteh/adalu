class OrderModel {
  int _id;
  int _customerId;
  String _customerType;
  String _paymentStatus;
  String _orderStatus;
  String _paymentMethod;
  String _transactionRef;
  double _orderAmount;
  String _shippingAddress;
  String _createdAt;
  String _updatedAt;
  double _discountAmount;
  String _discountType;
  String _paymentLink;
  String _paymentLinkCreateAt;
  String _resi;

  OrderModel(
      {int id,
        int customerId,
        String customerType,
        String paymentStatus,
        String orderStatus,
        String paymentMethod,
        String transactionRef,
        double orderAmount,
        String shippingAddress,
        String createdAt,
        String updatedAt,
        double discountAmount,
        String discountType,
        String paymentLink,
        String paymentLinkCreateAt,
        String resi,
      }) {
    this._id = id;
    this._customerId = customerId;
    this._customerType = customerType;
    this._paymentStatus = paymentStatus;
    this._orderStatus = orderStatus;
    this._paymentMethod = paymentMethod;
    this._transactionRef = transactionRef;
    this._orderAmount = orderAmount;
    this._shippingAddress = shippingAddress;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._discountAmount = discountAmount;
    this._discountType = discountType;
    this._paymentLink = paymentLink;
    this._paymentLinkCreateAt = paymentLinkCreateAt;
    this._resi = resi;
  }

  int get id => _id;
  int get customerId => _customerId;
  String get customerType => _customerType;
  String get paymentStatus => _paymentStatus;
  String get orderStatus => _orderStatus;
  String get paymentMethod => _paymentMethod;
  String get transactionRef => _transactionRef;
  double get orderAmount => _orderAmount;
  String get shippingAddress => _shippingAddress;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  double get discountAmount => _discountAmount;
  String get discountType => _discountType;
  String get paymentLink => _paymentLink;
  String get paymentLinkCreateAt => _paymentLinkCreateAt;
  String get resi => _resi;

  DateTime get paymentLinkCreateAtDateTime {
    if (this.paymentLinkCreateAt != null) {
      DateTime dateTime = DateTime.tryParse(this.paymentLinkCreateAt);

      if (dateTime != null) {
        return dateTime.add(Duration(days: 1));
      }

      return null;
    }

    return null;
  }

  bool isPaymentLinkDateTimeValid() {
    DateTime now = DateTime.now();

    if (paymentLinkCreateAtDateTime != null) {
      if (calculateDifference(paymentLinkCreateAtDateTime) == 0 || calculateDifference(paymentLinkCreateAtDateTime) == 1) {
        return true;
      }
      return false;
    }

    return false;
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  OrderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _customerType = json['customer_type'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['order_status'];
    _paymentMethod = json['payment_method'];
    _transactionRef = json['transaction_ref'];
    _orderAmount = json['order_amount'].toDouble();
    _shippingAddress = json['shipping_address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _discountAmount = json['discount_amount'].toDouble();
    _discountType = json['discount_type'];
    _paymentLink = json['payment_link'];
    _paymentLinkCreateAt = json['payment_link_create_at'];
    _resi = json['resi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['customer_id'] = this._customerId;
    data['customer_type'] = this._customerType;
    data['payment_status'] = this._paymentStatus;
    data['order_status'] = this._orderStatus;
    data['payment_method'] = this._paymentMethod;
    data['transaction_ref'] = this._transactionRef;
    data['order_amount'] = this._orderAmount;
    data['shipping_address'] = this._shippingAddress;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['discount_amount'] = this._discountAmount;
    data['discount_type'] = this._discountType;
    return data;
  }
}
