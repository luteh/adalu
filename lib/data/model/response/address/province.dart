class Province {
  int provinceId;
  String branchCode;
  String branchName;
  String districtCode;
  String districtName;
  String zoneCode;
  String cityCode;
  String cityName;
  String provinsiCode;
  String provinsiName;

  Province({
    this.provinceId = 0,
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

  Province copyWith({
    int provinceId,
    String branchCode,
    String branchName,
    String districtCode,
    String districtName,
    String zoneCode,
    String cityCode,
    String cityName,
    String provinsiCode,
    String provinsiName,
  }) {
    return Province(
      provinceId: provinceId ?? this.provinceId,
      branchCode: branchCode ?? this.branchCode,
      branchName: branchName ?? this.branchName,
      districtCode: districtCode ?? this.districtCode,
      districtName: districtName ?? this.districtName,
      zoneCode: zoneCode ?? this.zoneCode,
      cityCode: cityCode ?? this.cityCode,
      cityName: cityName ?? this.cityName,
      provinsiCode: provinsiCode ?? this.provinsiCode,
      provinsiName: provinsiName ?? this.provinsiName,
    );
  }

  Province.fromJson(Map<String, dynamic> json) {
    provinceId = json['Id'];
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
    data['Id'] = this.provinceId;
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
