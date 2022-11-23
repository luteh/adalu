class AddressModel {
  int id;
  int customerId;
  String contactPersonName;
  String addressType;
  String address;
  String city;
  String zip;
  String phone;
  String createdAt;
  String updatedAt;
  String provinceCode;
  String cityCode;
  String districtCode;

  AddressModel(
      {this.id,
        this.customerId,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.provinceCode,
        this.cityCode,
        this.districtCode,
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provinceCode = json['province_code'];
    cityCode = json['city_code'];
    districtCode = json['district_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['contact_person_name'] = this.contactPersonName;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['province_code'] = this.provinceCode;
    data['city_code'] = this.cityCode;
    data['district_code'] = this.districtCode;
    return data;
  }
}
