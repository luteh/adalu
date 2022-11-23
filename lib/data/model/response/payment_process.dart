class PaymentProcess {
  int _code;
  Data _data;

  PaymentProcess({int code, Data data}) {
    this._code = code;
    this._data = data;
  }

  int get code => _code;
  set code(int code) => _code = code;
  Data get data => _data;
  set data(Data data) => _data = data;

  PaymentProcess.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  String _customerNumber;
  String _virtualAccount;
  int _orderId;
  String _companyCode;
  int _amount;

  Data({
    String customerNumber,
    String virtualAccount,
    int orderId,
    String companyCode,
    int amount,
  }) {
    this._customerNumber = customerNumber;
    this._virtualAccount = virtualAccount;
    this._orderId = orderId;
    this._companyCode = companyCode;
    this._amount = amount;
  }

  String get customerNumber => _customerNumber;
  set customerNumber(String customerNumber) => _customerNumber = customerNumber;
  String get virtualAccount => _virtualAccount;
  set virtualAccount(String virtualAccount) => _virtualAccount = virtualAccount;
  int get orderId => _orderId;
  set orderId(int orderId) => _orderId = orderId;
  set companyCode(String companyCode) => _companyCode = companyCode;
  set amount(int amount) => _amount = amount;

  Data.fromJson(Map<String, dynamic> json) {
    _customerNumber = json['customer_number'];
    _virtualAccount = json['virtual_account'];
    _orderId = json['orders_id'];
    _companyCode = json['company_code'];
    _amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_number'] = this._customerNumber;
    data['virtual_account'] = this._virtualAccount;
    data['orders_id'] = this._orderId;
    data['company_code'] = this._companyCode;
    data['amount'] = this._amount;
    return data;
  }
}
