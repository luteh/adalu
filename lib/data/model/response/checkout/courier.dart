class Courier {
  String serviceTypeCode;
  String serviceTypeName;
  String serviceDesc;

  Courier({this.serviceTypeCode, this.serviceTypeName, this.serviceDesc});

  Courier.fromJson(Map<String, dynamic> json) {
    serviceTypeCode = json['service_type_code'];
    serviceTypeName = json['service_type_name'];
    serviceDesc = json['service_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_type_code'] = this.serviceTypeCode;
    data['service_type_name'] = this.serviceTypeName;
    data['service_desc'] = this.serviceDesc;
    return data;
  }

  String toString() {
    return "Courier {serviceTypeCode: ${serviceTypeCode}, serviceTypeName: ${serviceTypeName}, serviceDesc: ${serviceDesc}}";
  }
}
