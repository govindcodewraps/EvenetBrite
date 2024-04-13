// To parse this JSON data, do
//
//     final catWiseInfo = catWiseInfoFromJson(jsonString);

import 'dart:convert';

CatWiseInfo catWiseInfoFromJson(String str) =>
    CatWiseInfo.fromJson(json.decode(str));

String catWiseInfoToJson(CatWiseInfo data) => json.encode(data.toJson());

class CatWiseInfo {
  CatWiseInfo({
    required this.responseCode,
    required this.result,
    required this.responseMsg,
    required this.propertyCat,
  });

  String responseCode;
  String result;
  String responseMsg;
  List<PropertyCat> propertyCat;

  factory CatWiseInfo.fromJson(Map<String, dynamic> json) => CatWiseInfo(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
        propertyCat: List<PropertyCat>.from(
            json["Property_cat"].map((x) => PropertyCat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
        "Property_cat": List<dynamic>.from(propertyCat.map((x) => x.toJson())),
      };
}

class PropertyCat {
  PropertyCat({
    required this.id,
    required this.title,
    required this.buyorrent,
    required this.plimit,
    required this.rate,
    required this.city,
    required this.propertyType,
    required this.image,
    required this.price,
    required this.isFavourite,
  });

  String id;
  String title;
  String buyorrent;
  String plimit;
  String rate;
  String city;
  String propertyType;
  String image;
  String price;
  int isFavourite;

  factory PropertyCat.fromJson(Map<String, dynamic> json) => PropertyCat(
        id: json["id"],
        title: json["title"],
        buyorrent: json["buyorrent"],
        plimit: json["plimit"],
        rate: json["rate"],
        city: json["city"],
        propertyType: json["property_type"],
        image: json["image"],
        price: json["price"],
        isFavourite: json["IS_FAVOURITE"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "buyorrent": buyorrent,
        "plimit": plimit,
        "rate": rate,
        "city": city,
        "property_type": propertyType,
        "image": image,
        "price": price,
        "IS_FAVOURITE": isFavourite,
      };
}
