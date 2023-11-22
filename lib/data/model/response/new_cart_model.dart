import 'dart:convert';

class NewCartModel {
  int id;
  String choice22;
  String choice4;
  String choice15;
  Variations variations;
  String variant;
  int quantity;
  int shippingMethodId;
  num price;
  double tax;
  String slug;
  String name;
  num discount;
  num shippingCost;
  String thumbnail;
  String statusConfirmation;
  String statusMsg;
  int quantityConfirmed;

  NewCartModel({
    this.id,
    this.choice22,
    this.choice4,
    this.choice15,
    this.variations,
    this.variant,
    this.quantity,
    this.shippingMethodId,
    this.price,
    this.tax,
    this.slug,
    this.name,
    this.discount,
    this.shippingCost,
    this.thumbnail,
    this.statusConfirmation,
    this.statusMsg,
    this.quantityConfirmed,
  });

  factory NewCartModel.fromRawJson(String str) =>
      NewCartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewCartModel.fromJson(Map<String, dynamic> json) => NewCartModel(
        id: json["id"],
        choice22: json["choice_22"],
        choice4: json["choice_4"],
        choice15: json["choice_15"],
        variations: Variations.fromJson(json["variations"]),
        variant: json["variant"],
        quantity: json["quantity"],
        shippingMethodId: json["shipping_method_id"],
        price: json["price"],
        tax: json["tax"].toDouble(),
        slug: json["slug"],
        name: json["name"],
        discount: json["discount"],
        shippingCost: json["shipping_cost"],
        thumbnail: json["thumbnail"],
        statusConfirmation: json["status_confirmation"],
        statusMsg: json["status_msg"],
        quantityConfirmed: json["quantity_confirmed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "choice_22": choice22,
        "choice_4": choice4,
        "choice_15": choice15,
        "variations": variations.toJson(),
        "variant": variant,
        "quantity": quantity,
        "shipping_method_id": shippingMethodId,
        "price": price,
        "tax": tax,
        "slug": slug,
        "name": name,
        "discount": discount,
        "shipping_cost": shippingCost,
        "thumbnail": thumbnail,
        "statusConfirmation": statusConfirmation,
        "statusMsg": statusMsg,
        "quantityConfirmed": quantityConfirmed,
      };
}

class Variations {
  String os;
  String processor;
  String ram;

  Variations({
    this.os,
    this.processor,
    this.ram,
  });

  factory Variations.fromRawJson(String str) =>
      Variations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
        os: json["OS"],
        processor: json["PROCESSOR"],
        ram: json["RAM"],
      );

  Map<String, dynamic> toJson() => {
        "OS": os,
        "PROCESSOR": processor,
        "RAM": ram,
      };
}
