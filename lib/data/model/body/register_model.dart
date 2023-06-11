class RegisterModel {
  String email;
  String password;
  String fName;
  String lName;
  String phone;
  String npwpStr;
  String npwp;
  String company;
  String address;

  RegisterModel({
    this.email,
    this.password,
    this.fName,
    this.lName,
    this.phone,
    this.npwpStr,
    this.npwp,
    this.company,
    this.address,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    npwpStr = json['npwp_str'];
    npwp = json['npwp'];
    company = json['company'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['npwp_str'] = this.npwpStr;
    data['npwp'] = this.npwp;
    data['company'] = this.company;
    data['address'] = this.address;
    return data;
  }
}
