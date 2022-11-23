import 'package:flutter_rekret_ecommerce/data/model/response/address/city.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/address/province.dart';

class District {
  int subdistrictId;
  Province province;
  City city;
  String branchCode;
  String branchName;
  String districtCode;
  String districtName;
  String zoneCode;
  String cityCode;
  String cityName;
  String provinsiCode;
  String provinsiName;

  District({
    this.subdistrictId = 0,
    this.province,
    this.city,
    this.branchCode = '',
    this.branchName = '',
    this.districtCode = '',
    this.districtName = '',
    this.zoneCode = '',
    this.cityCode = '',
    this.cityName = '',
    this.provinsiCode = '',
    this.provinsiName = '',
  });

  District.fromJson(Map<String, dynamic> json) {
    subdistrictId = json['Id'];
    province = Province(
      provinceId: json['Id'],
      branchCode: json['Branch_Code'],
      branchName: json['Branch_Name'],
      districtCode: json['District_Code'],
      districtName: json['District_Name'],
      zoneCode: json['Zone_Code'],
      cityCode: json['City_Code'],
      cityName: json['City_Name'],
      provinsiCode: json['Provinsi_Code'],
      provinsiName: json['Provinsi_Name'],
    );
    city = City(
      province: province,
      cityId: json['Id'],
      branchCode: json['Branch_Code'],
      branchName: json['Branch_Name'],
      districtCode: json['District_Code'],
      districtName: json['District_Name'],
      zoneCode: json['Zone_Code'],
      cityCode: json['City_Code'],
      cityName: json['City_Name'],
      provinsiCode: json['Provinsi_Code'],
      provinsiName: json['Provinsi_Name'],
    );
    branchCode = json['Branch_Code'];
    branchName = json['Branch_Name'];
    districtCode = json['District_Code'];
    districtName = json['District_Name'];
    zoneCode = json['Zone_Code'];
    cityCode = json['City_Code'];
    cityName = json['City_Name'];
    provinsiCode = json['Provinsi_Code'];
    provinsiName = json['Provinsi_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subdistrict_id'] = this.subdistrictId;
    data['province_id'] = this.province.provinceId;
    data['province'] = this.province.provinsiCode;
    data['city_id'] = this.city.cityCode;
    data['city'] = this.city.cityName;
    data['Branch_Code'] = this.branchCode;
    data['Branch_Name'] = this.branchName;
    data['District_Code'] = this.districtCode;
    data['District_Name'] = this.districtName;
    data['Zone_Code'] = this.zoneCode;
    data['City_Code'] = this.cityCode;
    data['City_Name'] = this.cityName;
    data['Provinsi_Code'] = this.provinsiCode;
    data['Provinsi_Name'] = this.provinsiName;
    return data;
  }
}
