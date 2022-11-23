class RegisterModel {
  String email;
  String password;
  String fName;
  String lName;
  String phone;
  String npwpStr;

  RegisterModel({
    this.email,
    this.password,
    this.fName,
    this.lName,
    this.phone,
    this.npwpStr,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    npwpStr = json['npwp_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['npwp_str'] = this.npwpStr;
    return data;
  }
}
