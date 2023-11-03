// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(String str) =>
    ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
  ProductDetail({
    this.id,
    this.addedBy,
    this.userId,
    this.name,
    this.slug,
    this.categoryIds,
    this.brandId,
    this.guarantee,
    this.unit,
    this.unitWeight,
    this.unitLength,
    this.unitWidth,
    this.unitHeight,
    this.minQty,
    this.refundable,
    this.images,
    this.thumbnail,
    this.featured,
    this.flashDeal,
    this.videoProvider,
    this.videoUrl,
    this.colors,
    this.variantProduct,
    this.attributes,
    this.choiceOptions,
    this.variation,
    this.published,
    this.unitPrice,
    this.purchasePrice,
    this.feePrice,
    this.tax,
    this.taxType,
    this.discount,
    this.discountType,
    this.currentStock,
    this.details,
    this.freeShipping,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.featuredStatus,
    this.sellerExtra,
    this.rating,
    this.seller,
  });

  int id;
  String addedBy;
  int userId;
  String name;
  String slug;
  List<CategoryId> categoryIds;
  int brandId;
  String guarantee;
  String unit;
  String unitWeight;
  String unitLength;
  String unitWidth;
  String unitHeight;
  int minQty;
  int refundable;
  List<String> images;
  String thumbnail;
  dynamic featured;
  dynamic flashDeal;
  dynamic videoProvider;
  dynamic videoUrl;
  List<Color> colors;
  int variantProduct;
  List<String> attributes;
  List<ChoiceOption> choiceOptions;
  List<Variation> variation;
  int published;
  int unitPrice;
  int purchasePrice;
  String feePrice;
  int tax;
  String taxType;
  int discount;
  String discountType;
  int currentStock;
  String details;
  int freeShipping;
  dynamic attachment;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  int featuredStatus;
  SellerExtra sellerExtra;
  List<dynamic> rating;
  Seller seller;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        id: json["id"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        categoryIds: List<CategoryId>.from(
            json["category_ids"].map((x) => CategoryId.fromJson(x))),
        brandId: json["brand_id"],
        guarantee: json["guarantee"],
        unit: json["unit"],
        unitWeight: json["unit_weight"],
        unitLength: json["unit_length"],
        unitWidth: json["unit_width"],
        unitHeight: json["unit_height"],
        minQty: json["min_qty"],
        refundable: json["refundable"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
        featured: json["featured"],
        flashDeal: json["flash_deal"],
        videoProvider: json["video_provider"],
        videoUrl: json["video_url"],
        colors: List<Color>.from(json["colors"].map((x) => Color.fromJson(x))),
        variantProduct: int.tryParse(json["variant_product"]) ?? 0,
        attributes: json['attributes'] != null
            ? List<String>.from(json["attributes"].map((x) => x))
            : [],
        choiceOptions: List<ChoiceOption>.from(
            json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
        variation: List<Variation>.from(
            json["variation"].map((x) => Variation.fromJson(x))),
        published: json["published"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        feePrice: json["fee_price"],
        tax: json["tax"],
        taxType: json["tax_type"],
        discount: json["discount"],
        discountType: json["discount_type"],
        currentStock: json["current_stock"],
        details: json["details"],
        freeShipping: json["free_shipping"],
        attachment: json["attachment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        featuredStatus: json["featured_status"],
        sellerExtra: SellerExtra.fromJson(json["seller_extra"]),
        rating: List<dynamic>.from(json["rating"].map((x) => x)),
        seller: Seller.fromJson(json["seller"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "added_by": addedBy,
        "user_id": userId,
        "name": name,
        "slug": slug,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x.toJson())),
        "brand_id": brandId,
        "guarantee": guarantee,
        "unit": unit,
        "unit_weight": unitWeight,
        "unit_length": unitLength,
        "unit_width": unitWidth,
        "unit_height": unitHeight,
        "min_qty": minQty,
        "refundable": refundable,
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
        "featured": featured,
        "flash_deal": flashDeal,
        "video_provider": videoProvider,
        "video_url": videoUrl,
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
        "variant_product": variantProduct,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "choice_options":
            List<dynamic>.from(choiceOptions.map((x) => x.toJson())),
        "variation": List<dynamic>.from(variation.map((x) => x.toJson())),
        "published": published,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "fee_price": feePrice,
        "tax": tax,
        "tax_type": taxType,
        "discount": discount,
        "discount_type": discountType,
        "current_stock": currentStock,
        "details": details,
        "free_shipping": freeShipping,
        "attachment": attachment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "featured_status": featuredStatus,
        "seller_extra": sellerExtra.toJson(),
        "rating": List<dynamic>.from(rating.map((x) => x)),
        "seller": seller.toJson(),
      };
}

class CategoryId {
  CategoryId({
    this.id,
    this.position,
  });

  String id;
  int position;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
      };
}

class ChoiceOption {
  ChoiceOption({
    this.name,
    this.title,
    this.options,
  });

  String name;
  String title;
  List<String> options;

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
        name: json["name"],
        title: json["title"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "options": List<dynamic>.from(options.map((x) => x)),
      };
}

class Color {
  Color({
    this.name,
    this.code,
  });

  String name;
  String code;

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
      };
}

class Seller {
  Seller({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.image,
    this.idImage,
    this.companyFile,
    this.company,
    this.npwp,
    this.email,
    this.password,
    this.status,
    this.fees,
    this.rememberToken,
    this.recommended,
    this.createdAt,
    this.updatedAt,
    this.bankName,
    this.branch,
    this.accountNo,
    this.holderName,
    this.authToken,
    this.shop,
  });

  int id;
  String fName;
  String lName;
  String phone;
  String image;
  String idImage;
  String companyFile;
  String company;
  String npwp;
  String email;
  String password;
  String status;
  int fees;
  String rememberToken;
  int recommended;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic bankName;
  dynamic branch;
  dynamic accountNo;
  dynamic holderName;
  dynamic authToken;
  Shop shop;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        image: json["image"],
        idImage: json["id_image"],
        companyFile: json["company_file"],
        company: json["company"],
        npwp: json["npwp"],
        email: json["email"],
        password: json["password"],
        status: json["status"],
        fees: int.tryParse(json["fees"]) ?? 0,
        rememberToken: json["remember_token"],
        recommended: int.tryParse(json["recommended"]) ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bankName: json["bank_name"],
        branch: json["branch"],
        accountNo: json["account_no"],
        holderName: json["holder_name"],
        authToken: json["auth_token"],
        shop: Shop.fromJson(json["shop"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "image": image,
        "id_image": idImage,
        "company_file": companyFile,
        "company": company,
        "npwp": npwp,
        "email": email,
        "password": password,
        "status": status,
        "fees": fees,
        "remember_token": rememberToken,
        "recommended": recommended,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "bank_name": bankName,
        "branch": branch,
        "account_no": accountNo,
        "holder_name": holderName,
        "auth_token": authToken,
        "shop": shop.toJson(),
      };
}

class Shop {
  Shop({
    this.id,
    this.sellerId,
    this.name,
    this.address,
    this.provinceCode,
    this.cityCode,
    this.districtCode,
    this.contact,
    this.zipCode,
    this.npwpStr,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int sellerId;
  String name;
  String address;
  String provinceCode;
  String cityCode;
  String districtCode;
  String contact;
  String zipCode;
  String npwpStr;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        sellerId: int.tryParse(json["seller_id"]) ?? 0,
        name: json["name"],
        address: json["address"],
        provinceCode: json["province_code"],
        cityCode: json["city_code"],
        districtCode: json["district_code"],
        contact: json["contact"],
        zipCode: json["zip_code"],
        npwpStr: json["npwp_str"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "name": name,
        "address": address,
        "province_code": provinceCode,
        "city_code": cityCode,
        "district_code": districtCode,
        "contact": contact,
        "zip_code": zipCode,
        "npwp_str": npwpStr,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class SellerExtra {
  SellerExtra({
    this.location,
    this.badgePath,
    this.badgeOfficial,
    this.badgePro,
    this.badgeTop,
  });

  String location;
  String badgePath;
  String badgeOfficial;
  String badgePro;
  String badgeTop;

  factory SellerExtra.fromJson(Map<String, dynamic> json) => SellerExtra(
        location: json["location"],
        badgePath: json["badge_path"],
        badgeOfficial: json["badge_official"],
        badgePro: json["badge_pro"],
        badgeTop: json["badge_top"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "badge_path": badgePath,
        "badge_official": badgeOfficial,
        "badge_pro": badgePro,
        "badge_top": badgeTop,
      };
}

class Variation {
  Variation({
    this.type,
    this.price,
    this.sku,
    this.qty,
  });

  String type;
  int price;
  String sku;
  int qty;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        type: json["type"],
        price: json["price"],
        sku: json["sku"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
        "sku": sku,
        "qty": qty,
      };
}
