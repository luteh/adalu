class TrackOrder {
  OrderDetails _orderDetails;
  TrackDetail _trackDetail;
  Courier _courier;

  TrackOrder(
      {OrderDetails orderDetails, TrackDetail trackDetail, Courier courier}) {
    this._orderDetails = orderDetails;
    this._trackDetail = trackDetail;
    this._courier = courier;
  }

  OrderDetails get orderDetails => _orderDetails;
  set orderDetails(OrderDetails orderDetails) => _orderDetails = orderDetails;
  TrackDetail get trackDetail => _trackDetail;
  set trackDetail(TrackDetail trackDetail) => _trackDetail = trackDetail;
  Courier get courier => _courier;
  set courier(Courier courier) => _courier = courier;

  TrackOrder.fromJson(Map<String, dynamic> json) {
    _orderDetails = json['orderDetails'] != null
        ? new OrderDetails.fromJson(json['orderDetails'])
        : null;
    _trackDetail = json['track_detail'] != null
        ? new TrackDetail.fromJson(json['track_detail'])
        : null;
    _courier =
    json['courier'] != null ? new Courier.fromJson(json['courier']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._orderDetails != null) {
      data['orderDetails'] = this._orderDetails.toJson();
    }
    if (this._trackDetail != null) {
      data['track_detail'] = this._trackDetail.toJson();
    }
    if (this._courier != null) {
      data['courier'] = this._courier.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int _id;
  int _customerId;
  String _customerType;
  String _paymentStatus;
  String _orderStatus;
  String _paymentMethod;
  String _transactionRef;
  int _orderAmount;
  String _shippingAddress;
  Null _shippingCourier;
  Null _shippingCode;
  Null _shippingName;
  String _shippingFee;
  String _createdAt;
  String _updatedAt;
  int _discountAmount;
  String _discountType;

  OrderDetails(
      {int id,
        int customerId,
        String customerType,
        String paymentStatus,
        String orderStatus,
        String paymentMethod,
        String transactionRef,
        int orderAmount,
        String shippingAddress,
        Null shippingCourier,
        Null shippingCode,
        Null shippingName,
        String shippingFee,
        String createdAt,
        String updatedAt,
        int discountAmount,
        String discountType}) {
    this._id = id;
    this._customerId = customerId;
    this._customerType = customerType;
    this._paymentStatus = paymentStatus;
    this._orderStatus = orderStatus;
    this._paymentMethod = paymentMethod;
    this._transactionRef = transactionRef;
    this._orderAmount = orderAmount;
    this._shippingAddress = shippingAddress;
    this._shippingCourier = shippingCourier;
    this._shippingCode = shippingCode;
    this._shippingName = shippingName;
    this._shippingFee = shippingFee;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._discountAmount = discountAmount;
    this._discountType = discountType;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get customerId => _customerId;
  set customerId(int customerId) => _customerId = customerId;
  String get customerType => _customerType;
  set customerType(String customerType) => _customerType = customerType;
  String get paymentStatus => _paymentStatus;
  set paymentStatus(String paymentStatus) => _paymentStatus = paymentStatus;
  String get orderStatus => _orderStatus;
  set orderStatus(String orderStatus) => _orderStatus = orderStatus;
  String get paymentMethod => _paymentMethod;
  set paymentMethod(String paymentMethod) => _paymentMethod = paymentMethod;
  String get transactionRef => _transactionRef;
  set transactionRef(String transactionRef) => _transactionRef = transactionRef;
  int get orderAmount => _orderAmount;
  set orderAmount(int orderAmount) => _orderAmount = orderAmount;
  String get shippingAddress => _shippingAddress;
  set shippingAddress(String shippingAddress) =>
      _shippingAddress = shippingAddress;
  Null get shippingCourier => _shippingCourier;
  set shippingCourier(Null shippingCourier) =>
      _shippingCourier = shippingCourier;
  Null get shippingCode => _shippingCode;
  set shippingCode(Null shippingCode) => _shippingCode = shippingCode;
  Null get shippingName => _shippingName;
  set shippingName(Null shippingName) => _shippingName = shippingName;
  String get shippingFee => _shippingFee;
  set shippingFee(String shippingFee) => _shippingFee = shippingFee;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  int get discountAmount => _discountAmount;
  set discountAmount(int discountAmount) => _discountAmount = discountAmount;
  String get discountType => _discountType;
  set discountType(String discountType) => _discountType = discountType;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _customerType = json['customer_type'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['order_status'];
    _paymentMethod = json['payment_method'];
    _transactionRef = json['transaction_ref'];
    _orderAmount = json['order_amount'];
    _shippingAddress = json['shipping_address'];
    _shippingCourier = json['shipping_courier'];
    _shippingCode = json['shipping_code'];
    _shippingName = json['shipping_name'];
    _shippingFee = json['shipping_fee'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _discountAmount = json['discount_amount'];
    _discountType = json['discount_type'];
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
    data['shipping_courier'] = this._shippingCourier;
    data['shipping_code'] = this._shippingCode;
    data['shipping_name'] = this._shippingName;
    data['shipping_fee'] = this._shippingFee;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['discount_amount'] = this._discountAmount;
    data['discount_type'] = this._discountType;
    return data;
  }
}

class TrackDetail {
  Rajaongkir _rajaongkir;

  TrackDetail({Rajaongkir rajaongkir}) {
    this._rajaongkir = rajaongkir;
  }

  Rajaongkir get rajaongkir => _rajaongkir;
  set rajaongkir(Rajaongkir rajaongkir) => _rajaongkir = rajaongkir;

  TrackDetail.fromJson(Map<String, dynamic> json) {
    _rajaongkir = json['rajaongkir'] != null
        ? new Rajaongkir.fromJson(json['rajaongkir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._rajaongkir != null) {
      data['rajaongkir'] = this._rajaongkir.toJson();
    }
    return data;
  }
}

class Rajaongkir {
  Query _query;
  Status _status;
  Result _result;

  Rajaongkir({Query query, Status status, Result result}) {
    this._query = query;
    this._status = status;
    this._result = result;
  }

  Query get query => _query;
  set query(Query query) => _query = query;
  Status get status => _status;
  set status(Status status) => _status = status;
  Result get result => _result;
  set result(Result result) => _result = result;

  Rajaongkir.fromJson(Map<String, dynamic> json) {
    _query = json['query'] != null ? new Query.fromJson(json['query']) : null;
    _status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    _result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._query != null) {
      data['query'] = this._query.toJson();
    }
    if (this._status != null) {
      data['status'] = this._status.toJson();
    }
    if (this._result != null) {
      data['result'] = this._result.toJson();
    }
    return data;
  }
}

class Query {
  String _waybill;
  String _courier;

  Query({String waybill, String courier}) {
    this._waybill = waybill;
    this._courier = courier;
  }

  String get waybill => _waybill;
  set waybill(String waybill) => _waybill = waybill;
  String get courier => _courier;
  set courier(String courier) => _courier = courier;

  Query.fromJson(Map<String, dynamic> json) {
    _waybill = json['waybill'];
    _courier = json['courier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waybill'] = this._waybill;
    data['courier'] = this._courier;
    return data;
  }
}

class Status {
  int _code;
  String _description;

  Status({int code, String description}) {
    this._code = code;
    this._description = description;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get description => _description;
  set description(String description) => _description = description;

  Status.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['description'] = this._description;
    return data;
  }
}

class Result {
  bool _delivered;
  Summary _summary;
  Details _details;
  DeliveryStatus _deliveryStatus;
  List<Manifest> _manifest;

  Result(
      {bool delivered,
        Summary summary,
        Details details,
        DeliveryStatus deliveryStatus,
        List<Manifest> manifest}) {
    this._delivered = delivered;
    this._summary = summary;
    this._details = details;
    this._deliveryStatus = deliveryStatus;
    this._manifest = manifest;
  }

  bool get delivered => _delivered;
  set delivered(bool delivered) => _delivered = delivered;
  Summary get summary => _summary;
  set summary(Summary summary) => _summary = summary;
  Details get details => _details;
  set details(Details details) => _details = details;
  DeliveryStatus get deliveryStatus => _deliveryStatus;
  set deliveryStatus(DeliveryStatus deliveryStatus) =>
      _deliveryStatus = deliveryStatus;
  List<Manifest> get manifest => _manifest;
  set manifest(List<Manifest> manifest) => _manifest = manifest;

  Result.fromJson(Map<String, dynamic> json) {
    _delivered = json['delivered'];
    _summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    _details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    _deliveryStatus = json['delivery_status'] != null
        ? new DeliveryStatus.fromJson(json['delivery_status'])
        : null;
    if (json['manifest'] != null) {
      _manifest = new List<Manifest>();
      json['manifest'].forEach((v) {
        _manifest.add(new Manifest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivered'] = this._delivered;
    if (this._summary != null) {
      data['summary'] = this._summary.toJson();
    }
    if (this._details != null) {
      data['details'] = this._details.toJson();
    }
    if (this._deliveryStatus != null) {
      data['delivery_status'] = this._deliveryStatus.toJson();
    }
    if (this._manifest != null) {
      data['manifest'] = this._manifest.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  String _courierCode;
  String _courierName;
  String _waybillNumber;
  String _serviceCode;
  String _waybillDate;
  String _shipperName;
  String _receiverName;
  String _origin;
  String _destination;
  String _status;

  Summary(
      {String courierCode,
        String courierName,
        String waybillNumber,
        String serviceCode,
        String waybillDate,
        String shipperName,
        String receiverName,
        String origin,
        String destination,
        String status}) {
    this._courierCode = courierCode;
    this._courierName = courierName;
    this._waybillNumber = waybillNumber;
    this._serviceCode = serviceCode;
    this._waybillDate = waybillDate;
    this._shipperName = shipperName;
    this._receiverName = receiverName;
    this._origin = origin;
    this._destination = destination;
    this._status = status;
  }

  String get courierCode => _courierCode;
  set courierCode(String courierCode) => _courierCode = courierCode;
  String get courierName => _courierName;
  set courierName(String courierName) => _courierName = courierName;
  String get waybillNumber => _waybillNumber;
  set waybillNumber(String waybillNumber) => _waybillNumber = waybillNumber;
  String get serviceCode => _serviceCode;
  set serviceCode(String serviceCode) => _serviceCode = serviceCode;
  String get waybillDate => _waybillDate;
  set waybillDate(String waybillDate) => _waybillDate = waybillDate;
  String get shipperName => _shipperName;
  set shipperName(String shipperName) => _shipperName = shipperName;
  String get receiverName => _receiverName;
  set receiverName(String receiverName) => _receiverName = receiverName;
  String get origin => _origin;
  set origin(String origin) => _origin = origin;
  String get destination => _destination;
  set destination(String destination) => _destination = destination;
  String get status => _status;
  set status(String status) => _status = status;

  Summary.fromJson(Map<String, dynamic> json) {
    _courierCode = json['courier_code'];
    _courierName = json['courier_name'];
    _waybillNumber = json['waybill_number'];
    _serviceCode = json['service_code'];
    _waybillDate = json['waybill_date'];
    _shipperName = json['shipper_name'];
    _receiverName = json['receiver_name'];
    _origin = json['origin'];
    _destination = json['destination'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courier_code'] = this._courierCode;
    data['courier_name'] = this._courierName;
    data['waybill_number'] = this._waybillNumber;
    data['service_code'] = this._serviceCode;
    data['waybill_date'] = this._waybillDate;
    data['shipper_name'] = this._shipperName;
    data['receiver_name'] = this._receiverName;
    data['origin'] = this._origin;
    data['destination'] = this._destination;
    data['status'] = this._status;
    return data;
  }
}

class Details {
  String _waybillNumber;
  String _waybillDate;
  String _waybillTime;
  String _weight;
  String _origin;
  String _destination;
  String _shippperName;
  String _shipperAddress1;
  String _shipperAddress2;
  String _shipperAddress3;
  String _shipperCity;
  String _receiverName;
  String _receiverAddress1;
  String _receiverAddress2;
  String _receiverAddress3;
  String _receiverCity;

  Details(
      {String waybillNumber,
        String waybillDate,
        String waybillTime,
        String weight,
        String origin,
        String destination,
        String shippperName,
        String shipperAddress1,
        String shipperAddress2,
        String shipperAddress3,
        String shipperCity,
        String receiverName,
        String receiverAddress1,
        String receiverAddress2,
        String receiverAddress3,
        String receiverCity}) {
    this._waybillNumber = waybillNumber;
    this._waybillDate = waybillDate;
    this._waybillTime = waybillTime;
    this._weight = weight;
    this._origin = origin;
    this._destination = destination;
    this._shippperName = shippperName;
    this._shipperAddress1 = shipperAddress1;
    this._shipperAddress2 = shipperAddress2;
    this._shipperAddress3 = shipperAddress3;
    this._shipperCity = shipperCity;
    this._receiverName = receiverName;
    this._receiverAddress1 = receiverAddress1;
    this._receiverAddress2 = receiverAddress2;
    this._receiverAddress3 = receiverAddress3;
    this._receiverCity = receiverCity;
  }

  String get waybillNumber => _waybillNumber;
  set waybillNumber(String waybillNumber) => _waybillNumber = waybillNumber;
  String get waybillDate => _waybillDate;
  set waybillDate(String waybillDate) => _waybillDate = waybillDate;
  String get waybillTime => _waybillTime;
  set waybillTime(String waybillTime) => _waybillTime = waybillTime;
  String get weight => _weight;
  set weight(String weight) => _weight = weight;
  String get origin => _origin;
  set origin(String origin) => _origin = origin;
  String get destination => _destination;
  set destination(String destination) => _destination = destination;
  String get shippperName => _shippperName;
  set shippperName(String shippperName) => _shippperName = shippperName;
  String get shipperAddress1 => _shipperAddress1;
  set shipperAddress1(String shipperAddress1) =>
      _shipperAddress1 = shipperAddress1;
  String get shipperAddress2 => _shipperAddress2;
  set shipperAddress2(String shipperAddress2) =>
      _shipperAddress2 = shipperAddress2;
  String get shipperAddress3 => _shipperAddress3;
  set shipperAddress3(String shipperAddress3) =>
      _shipperAddress3 = shipperAddress3;
  String get shipperCity => _shipperCity;
  set shipperCity(String shipperCity) => _shipperCity = shipperCity;
  String get receiverName => _receiverName;
  set receiverName(String receiverName) => _receiverName = receiverName;
  String get receiverAddress1 => _receiverAddress1;
  set receiverAddress1(String receiverAddress1) =>
      _receiverAddress1 = receiverAddress1;
  String get receiverAddress2 => _receiverAddress2;
  set receiverAddress2(String receiverAddress2) =>
      _receiverAddress2 = receiverAddress2;
  String get receiverAddress3 => _receiverAddress3;
  set receiverAddress3(String receiverAddress3) =>
      _receiverAddress3 = receiverAddress3;
  String get receiverCity => _receiverCity;
  set receiverCity(String receiverCity) => _receiverCity = receiverCity;

  Details.fromJson(Map<String, dynamic> json) {
    _waybillNumber = json['waybill_number'];
    _waybillDate = json['waybill_date'];
    _waybillTime = json['waybill_time'];
    _weight = json['weight'];
    _origin = json['origin'];
    _destination = json['destination'];
    _shippperName = json['shippper_name'];
    _shipperAddress1 = json['shipper_address1'];
    _shipperAddress2 = json['shipper_address2'];
    _shipperAddress3 = json['shipper_address3'];
    _shipperCity = json['shipper_city'];
    _receiverName = json['receiver_name'];
    _receiverAddress1 = json['receiver_address1'];
    _receiverAddress2 = json['receiver_address2'];
    _receiverAddress3 = json['receiver_address3'];
    _receiverCity = json['receiver_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waybill_number'] = this._waybillNumber;
    data['waybill_date'] = this._waybillDate;
    data['waybill_time'] = this._waybillTime;
    data['weight'] = this._weight;
    data['origin'] = this._origin;
    data['destination'] = this._destination;
    data['shippper_name'] = this._shippperName;
    data['shipper_address1'] = this._shipperAddress1;
    data['shipper_address2'] = this._shipperAddress2;
    data['shipper_address3'] = this._shipperAddress3;
    data['shipper_city'] = this._shipperCity;
    data['receiver_name'] = this._receiverName;
    data['receiver_address1'] = this._receiverAddress1;
    data['receiver_address2'] = this._receiverAddress2;
    data['receiver_address3'] = this._receiverAddress3;
    data['receiver_city'] = this._receiverCity;
    return data;
  }
}

class DeliveryStatus {
  String _status;
  String _podReceiver;
  String _podDate;
  String _podTime;

  DeliveryStatus(
      {String status, String podReceiver, String podDate, String podTime}) {
    this._status = status;
    this._podReceiver = podReceiver;
    this._podDate = podDate;
    this._podTime = podTime;
  }

  String get status => _status;
  set status(String status) => _status = status;
  String get podReceiver => _podReceiver;
  set podReceiver(String podReceiver) => _podReceiver = podReceiver;
  String get podDate => _podDate;
  set podDate(String podDate) => _podDate = podDate;
  String get podTime => _podTime;
  set podTime(String podTime) => _podTime = podTime;

  DeliveryStatus.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _podReceiver = json['pod_receiver'];
    _podDate = json['pod_date'];
    _podTime = json['pod_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['pod_receiver'] = this._podReceiver;
    data['pod_date'] = this._podDate;
    data['pod_time'] = this._podTime;
    return data;
  }
}

class Manifest {
  String _manifestCode;
  String _manifestDescription;
  String _manifestDate;
  String _manifestTime;
  String _cityName;

  Manifest(
      {String manifestCode,
        String manifestDescription,
        String manifestDate,
        String manifestTime,
        String cityName}) {
    this._manifestCode = manifestCode;
    this._manifestDescription = manifestDescription;
    this._manifestDate = manifestDate;
    this._manifestTime = manifestTime;
    this._cityName = cityName;
  }

  String get manifestCode => _manifestCode;
  set manifestCode(String manifestCode) => _manifestCode = manifestCode;
  String get manifestDescription => _manifestDescription;
  set manifestDescription(String manifestDescription) =>
      _manifestDescription = manifestDescription;
  String get manifestDate => _manifestDate;
  set manifestDate(String manifestDate) => _manifestDate = manifestDate;
  String get manifestTime => _manifestTime;
  set manifestTime(String manifestTime) => _manifestTime = manifestTime;
  String get cityName => _cityName;
  set cityName(String cityName) => _cityName = cityName;

  Manifest.fromJson(Map<String, dynamic> json) {
    _manifestCode = json['manifest_code'];
    _manifestDescription = json['manifest_description'];
    _manifestDate = json['manifest_date'];
    _manifestTime = json['manifest_time'];
    _cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manifest_code'] = this._manifestCode;
    data['manifest_description'] = this._manifestDescription;
    data['manifest_date'] = this._manifestDate;
    data['manifest_time'] = this._manifestTime;
    data['city_name'] = this._cityName;
    return data;
  }
}

class Courier {
  int _idKurir;
  String _kodeKurir;
  String _namaKurir;

  Courier({int idKurir, String kodeKurir, String namaKurir}) {
    this._idKurir = idKurir;
    this._kodeKurir = kodeKurir;
    this._namaKurir = namaKurir;
  }

  int get idKurir => _idKurir;
  set idKurir(int idKurir) => _idKurir = idKurir;
  String get kodeKurir => _kodeKurir;
  set kodeKurir(String kodeKurir) => _kodeKurir = kodeKurir;
  String get namaKurir => _namaKurir;
  set namaKurir(String namaKurir) => _namaKurir = namaKurir;

  Courier.fromJson(Map<String, dynamic> json) {
    _idKurir = json['id_kurir'];
    _kodeKurir = json['kode_kurir'];
    _namaKurir = json['nama_kurir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_kurir'] = this._idKurir;
    data['kode_kurir'] = this._kodeKurir;
    data['nama_kurir'] = this._namaKurir;
    return data;
  }
}
