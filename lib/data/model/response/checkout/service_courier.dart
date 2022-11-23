// class ServiceCourier {
//   String service;
//   String description;
//   List<Cost> cost;
//   String courierId;

//   ServiceCourier(
//       {this.service = '',
//       this.description = '',
//       this.cost = const [],
//       this.courierId = ''});

//   ServiceCourier copyWith({
//     String service,
//     String description,
//     List<Cost> cost,
//     String courierId,
//   }) {
//     return ServiceCourier(
//       service: service ?? this.service,
//       description: description ?? this.description,
//       cost: cost ?? this.cost,
//       courierId: courierId ?? this.courierId,
//     );
//   }

//   ServiceCourier.fromJson(Map<String, dynamic> json) {
//     service = json['service'];
//     description = json['description'];
//     if (json['cost'] != null) {
//       cost = new List<Cost>();
//       json['cost'].forEach((v) {
//         cost.add(new Cost.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['service'] = this.service;
//     data['description'] = this.description;
//     if (this.cost != null) {
//       data['cost'] = this.cost.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }

//   String toString() {
//     return "ServiceCourier : {service: ${service}, description: ${description}, cost: ${cost.toString()}, courierId: ${courierId}}";
//   }

//   double costValue() {
//     if (this.cost.isNotEmpty) {
//       if (this.cost[0] != null) {
//         double value = double.tryParse(this.cost[0].value.toString() ?? "0");

//         return value;
//       }
//     }
//   }
// }

// class Cost {
//   int value;
//   String etd;
//   String note;

//   Cost({this.value, this.etd, this.note});

//   Cost.fromJson(Map<String, dynamic> json) {
//     value = json['value'];
//     etd = json['etd'];
//     note = json['note'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['value'] = this.value;
//     data['etd'] = this.etd;
//     data['note'] = this.note;
//     return data;
//   }

//   String toString() {
//     return "Cost : {value: ${value}, etd: ${etd}, note: ${note}";
//   }
// }

class ServiceCourier {
  String serviceTypeCode;
  String serviceTypeName;
  String serviceDesc;

  ServiceCourier(
      {this.serviceTypeCode, this.serviceTypeName, this.serviceDesc});

  ServiceCourier.fromJson(Map<String, dynamic> json) {
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
    return "ServiceCourier {serviceTypeCode: ${serviceTypeCode}, serviceTypeName: ${serviceTypeName}, serviceDesc: ${serviceDesc}}";
  }
}
