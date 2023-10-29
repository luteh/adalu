import 'dart:convert';

class DeliveredProductDetailModel {
  int id;
  String addedBy;
  int userId;
  String name;

  DeliveredProductDetailModel({
    this.id,
    this.addedBy,
    this.userId,
    this.name,
  });

  factory DeliveredProductDetailModel.fromRawJson(String str) =>
      DeliveredProductDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveredProductDetailModel.fromJson(Map<String, dynamic> json) =>
      DeliveredProductDetailModel(
        id: json["id"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "added_by": addedBy,
        "user_id": userId,
        "name": name,
      };
}
