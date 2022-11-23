class ServiceFee {
  String _code;
  String _name;
  String _amount;
  String _duration;
  String _total;
  int _shipmentNominal;
  double _totalNominal;

  ServiceFee(
      {String code,
        String name,
        String amount,
        String duration,
        String total,
        int shipmentNominal,
        double totalNominal}) {
    this._code = code;
    this._name = name;
    this._amount = amount;
    this._duration = duration;
    this._total = total;
    this._shipmentNominal = shipmentNominal;
    this._totalNominal = totalNominal;
  }

  String get code => _code;
  set code(String code) => _code = code;
  String get name => _name;
  set name(String name) => _name = name;
  String get amount => _amount;
  set amount(String amount) => _amount = amount;
  String get duration => _duration;
  set duration(String duration) => _duration = duration;
  String get total => _total;
  set total(String total) => _total = total;
  int get shipmentNominal => _shipmentNominal;
  set shipmentNominal(int shipmentNominal) =>
      _shipmentNominal = shipmentNominal;
  double get totalNominal => _totalNominal;
  set totalNominal(double totalNominal) => _totalNominal = totalNominal;

  ServiceFee.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _name = json['name'];
    _amount = json['amount'];
    _duration = json['duration'];
    _total = json['total'];
    _shipmentNominal = json['shipment_nominal'];
    _totalNominal = (json['total_nominal'] != null) ? double.tryParse(json['total_nominal'].toString()) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['name'] = this._name;
    data['amount'] = this._amount;
    data['duration'] = this._duration;
    data['total'] = this._total;
    data['shipment_nominal'] = this._shipmentNominal;
    data['total_nominal'] = this._totalNominal;
    return data;
  }
}
